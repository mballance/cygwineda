
ifneq (true,$(RULES))

# Definitions for packages
SYSTEMC_VERSION := 2.3.1
SYSTEMC_PKGNAME := systemc-$(SYSTEMC_VERSION)
SYSTEMC_URL := http://www.accellera.org/images/downloads/standards/systemc/systemc-$(SYSTEMC_VERSION).tgz
SYSTEMC_SRC_PKG := $(PKG_SRC_DIR)/systemc-$(SYSTEMC_VERSION).tar.gz
SYSTEMC_PKG := $(PKG_RESULT_DIR)/$(SYSTEMC_PKGNAME).tar.bz2
SYSTEMC_PKG_DIR := $(subst .tar.bz2,,$(SYSTEMC_PKG))
SYSTEMC_BUILDDIR := $(BUILD_DIR)/systemc-$(SYSTEMC_VERSION)
PACKAGE_RESULTS += $(SYSTEMC_PKG)
PACKAGE_NAMES += systemc

else

# Rules for packages
$(SYSTEMC_SRC_PKG) : $(MKDIRS)
	$(Q)echo "Download $(SYSTEMC_SRC_PKG)"
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)$(WGET) -O $@ $(SYSTEMC_URL)

$(SYSTEMC_PKG) : $(BUILD_DIR)/systemc.build
	$(Q)echo "Copying SystemC Result Files"
	$(Q)rm -rf $(SYSTEMC_PKG_DIR)
	$(Q)mkdir -p $(SYSTEMC_PKG_DIR)
	$(Q)mkdir -p $(SYSTEMC_PKG_DIR)/usr/lib/systemc
	$(Q)cp -r $(SYSTEMC_BUILDDIR)/include $(SYSTEMC_PKG_DIR)/usr/lib/systemc
	$(Q)cp -r $(SYSTEMC_BUILDDIR)/lib-* $(SYSTEMC_PKG_DIR)/usr/lib/systemc
	$(Q)echo "Packing $@"
	$(Q)cd $(SYSTEMC_PKG_DIR) ; $(TARBZ) $@ *
	$(Q)rm -rf $(SYSTEMC_PKG_DIR)

$(BUILD_DIR)/systemc.build : $(SYSTEMC_SRC_PKG) mkdirs
	$(Q)echo "Unpacking $(SYSTEMC_SRC_PKG)"
	$(Q)rm -rf $(SYSTEMC_BUILDDIR)
	$(Q)cd $(BUILD_DIR) ; $(UNTARGZ) $(SYSTEMC_SRC_PKG)
	$(Q)echo "Configuring $(SYSTEMC_SRC_PKG)"
	$(Q)cd $(SYSTEMC_BUILDDIR) ; ./configure --enable-pthreads
	$(Q)echo "Building $(SYSTEMC_SRC_PKG)"
	$(Q)cd $(SYSTEMC_BUILDDIR) ; $(MAKE)
	$(Q)echo "Installing $(SYSTEMC_SRC_PKG)"
	$(Q)cd $(SYSTEMC_BUILDDIR) ; $(MAKE) install
	$(Q)touch $@
	
systemc : $(SYSTEMC_PKG)

endif
