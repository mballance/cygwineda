
ifneq (true,$(RULES))

# Definitions for packages
GTKWAVE_VERSION := 3.3.70
GTKWAVE_PKGNAME := gtkwave-$(GTKWAVE_VERSION)
GTKWAVE_URL := http://gtkwave.sourceforge.net/gtkwave-$(GTKWAVE_VERSION).tar.gz
GTKWAVE_SRC_PKG := $(PKG_SRC_DIR)/gtkwave-$(GTKWAVE_VERSION).tar.gz
GTKWAVE_PKG := $(PKG_RESULT_DIR)/$(GTKWAVE_PKGNAME).tar.bz2
GTKWAVE_PKG_DIR := $(subst .tar.bz2,,$(GTKWAVE_PKG))
GTKWAVE_BUILDDIR := $(BUILD_DIR)/gtkwave-$(GTKWAVE_VERSION)
CORE_PACKAGE_RESULTS += $(GTKWAVE_PKG)
CORE_PACKAGE_NAMES += gtkwave

else

# Rules for packages
$(GTKWAVE_SRC_PKG) : $(MKDIRS)
	$(Q)echo "Download $(GTKWAVE_URL)"
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)$(WGET) -O $@ $(GTKWAVE_URL)

$(GTKWAVE_PKG) : $(BUILD_DIR)/gtkwave.build
	$(Q)echo "Copying GTKWave Result Files"
	$(Q)rm -rf $(GTKWAVE_PKG_DIR)
	$(Q)mkdir -p $(GTKWAVE_PKG_DIR)
	$(Q)mkdir -p $(GTKWAVE_PKG_DIR)/usr
	$(Q)cp -r $(GTKWAVE_BUILDDIR)/installdir/* $(GTKWAVE_PKG_DIR)/usr
	$(Q)echo "Packing $@"
	$(Q)cd $(GTKWAVE_PKG_DIR) ; $(TARBZ) $@ *
	$(Q)rm -rf $(GTKWAVE_PKG_DIR)

$(BUILD_DIR)/gtkwave.build : $(GTKWAVE_SRC_PKG) $(MKDIRS)
	$(Q)echo "Unpacking $(GTKWAVE_PKGNAME)"
	$(Q)rm -rf $(GTKWAVE_BUILDDIR)
	$(Q)cd $(BUILD_DIR) ; $(UNTARGZ) $(GTKWAVE_SRC_PKG)
	$(Q)echo "Configuring $(GTKWAVE_PKGNAME)"
	$(Q)cd $(GTKWAVE_BUILDDIR) ; ./configure \
	    --prefix=$(GTKWAVE_BUILDDIR)/installdir --disable-tcl 
	$(Q)echo "Building $(GTKWAVE_PKGNAME)"
	$(Q)cd $(GTKWAVE_BUILDDIR) ; $(MAKE)
	$(Q)echo "Installing $(GTKWAVE_PKGNAME)"
	$(Q)cd $(GTKWAVE_BUILDDIR) ; $(MAKE) install
	$(Q)rm -rf $(GTKWAVE_BUILDDIR)
	$(Q)touch $@
	
gtkwave : $(GTKWAVE_PKG)

endif
