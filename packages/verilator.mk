
ifneq (true,$(RULES))

# Definitions for packages
VERILATOR_VERSION := 3.880
VERILATOR_PKGNAME := verilator-$(VERILATOR_VERSION)
VERILATOR_URL := http://www.veripool.org/ftp/verilator-$(VERILATOR_VERSION).tgz
VERILATOR_SRC_PKG := $(PKG_SRC_DIR)/verilator-$(VERILATOR_VERSION).tar.gz
VERILATOR_PKG := $(PKG_RESULT_DIR)/$(VERILATOR_PKGNAME).tar.bz2
VERILATOR_PKG_DIR := $(subst .tar.bz2,,$(VERILATOR_PKG))
VERILATOR_BUILDDIR := $(BUILD_DIR)/verilator-$(VERILATOR_VERSION)
CORE_PACKAGE_RESULTS += $(VERILATOR_PKG)
CORE_PACKAGE_NAMES += verilator

else

# Rules for packages
$(VERILATOR_SRC_PKG) : $(MKDIRS)
	$(Q)echo "Download $(VERILATOR_SRC_PKG)"
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)$(WGET) -O $@ $(VERILATOR_URL)

$(VERILATOR_PKG) : $(BUILD_DIR)/verilator.build
	$(Q)echo "Copying Verilator Result Files"
	$(Q)rm -rf $(VERILATOR_PKG_DIR)
	$(Q)mkdir -p $(VERILATOR_PKG_DIR)/usr
	$(Q)cp -r $(VERILATOR_BUILDDIR)/installdir/* $(VERILATOR_PKG_DIR)/usr/
	$(Q)echo "Packing $@"
	$(Q)cd $(VERILATOR_PKG_DIR) ; $(TARBZ) $@ *
	$(Q)rm -rf $(VERILATOR_PKG_DIR)

$(BUILD_DIR)/verilator.build : $(VERILATOR_SRC_PKG) $(MKDIRS)
	$(Q)echo "Unpacking $(VERILATOR_PKGNAME)"
	$(Q)rm -rf $(VERILATOR_BUILDDIR)
	$(Q)cd $(BUILD_DIR) ; $(UNTARGZ) $(VERILATOR_SRC_PKG)
# Sometimes the first configuration fails
	$(Q)echo "Configuring $(VERILATOR_PKGNAME)"
	-$(Q)cd $(VERILATOR_BUILDDIR) ; ./configure --prefix=$(VERILATOR_BUILDDIR)/installdir
	$(Q)cd $(VERILATOR_BUILDDIR) ; if test ! -f Makefile; then echo "Trying again (1)"; \
	    ./configure --prefix=$(VERILATOR_BUILDDIR)/installdir; fi
	$(Q)cd $(VERILATOR_BUILDDIR) ; if test ! -f Makefile; then echo "Trying again (2)"; \
	    ./configure --prefix=$(VERILATOR_BUILDDIR)/installdir; fi
	$(Q)cd $(VERILATOR_BUILDDIR) ; if test ! -f Makefile; then echo "Trying again (3)"; \
	    ./configure --prefix=$(VERILATOR_BUILDDIR)/installdir; fi
	$(Q)cd $(VERILATOR_BUILDDIR) ; if test ! -f Makefile; then echo "Trying again (4)"; \
	    ./configure --prefix=$(VERILATOR_BUILDDIR)/installdir; fi
	$(Q)echo "Building $(VERILATOR_PKGNAME)"
	$(Q)cd $(VERILATOR_BUILDDIR) ; $(MAKE)
	$(Q)echo "Installing $(VERILATOR_PKGNAME)"
	$(Q)cd $(VERILATOR_BUILDDIR) ; $(MAKE) install
	$(Q)touch $@
	
verilator : $(VERILATOR_PKG)

endif
