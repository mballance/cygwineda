
ifneq (true,$(RULES))

# Definitions for packages
GCC_OR1KND_ELF_VERSION := 3.3.70
GCC_OR1KND_ELF_PKGNAME := gcc-or1knd-elf-$(GCC_OR1KND_ELF_VERSION)
GCC_OR1KND_ELF_NEWLIB_SRC_URL:=ftp://mirrors.kernel.org/sourceware/newlib/newlib-2.2.0.20150225.tar.gz
GCC_OR1KND_ELF_GMP_SRC_URL:=ftp://mirrors.kernel.org/gnu/gmp/gmp-4.3.2.tar.bz2
GCC_OR1KND_ELF_MPFR_SRC_URL:=ftp://mirrors.kernel.org/gnu/mpfr/mpfr-2.4.2.tar.bz2
GCC_OR1KND_ELF_MPC_SRC_URL:=ftp://mirrors.kernel.org/gnu/mpc/mpc-1.0.3.tar.gz
GCC_OR1KND_ELF_BINUTILS_SRC_URL:=ftp://mirrors.kernel.org/gnu/binutils/binutils-2.25.tar.bz2
GCC_OR1KND_ELF_OR1K_SRC_URL:=https://github.com/openrisc/or1k-src/archive/or1k.zip 
GCC_OR1KND_ELF_OR1K_GCC_URL:=https://github.com/openrisc/or1k-gcc/archive/or1k.zip

GCC_OR1KND_ELF_OR1K_SRC_PKG := $(PKG_SRC_DIR)/or1k-src.zip
GCC_OR1KND_ELF_OR1K_GCC_PKG := $(PKG_SRC_DIR)/or1k-gcc.zip
GCC_OR1KND_ELF_NEWLIB_PKG:=$(PKG_SRC_DIR)/newlib-2.2.0.20150225.tar.gz
GCC_OR1KND_ELF_GMP_PKG:=$(PKG_SRC_DIR)/gmp-4.3.2.tar.bz2
GCC_OR1KND_ELF_MPFR_PKG:=$(PKG_SRC_DIR)/mpfr-2.4.2.tar.bz2
GCC_OR1KND_ELF_MPC_PKG:=$(PKG_SRC_DIR)/mpc-1.0.3.tar.gz
GCC_OR1KND_ELF_BINUTILS_PKG:=$(PKG_SRC_DIR)/binutils-2.25.tar.bz2

GCC_OR1KND_ELF_PKG := $(PKG_RESULT_DIR)/$(GCC_OR1KND_ELF_PKGNAME).tar.bz2
GCC_OR1KND_ELF_PKG_DIR := $(subst .tar.bz2,,$(GCC_OR1KND_ELF_PKG))
GCC_OR1KND_ELF_BUILDDIR := $(BUILD_DIR)/gcc-or1knd-elf-$(GCC_OR1KND_ELF_VERSION)
GCC_PACKAGE_RESULTS += $(GCC_OR1KND_ELF_PKG)
GCC_PACKAGE_NAMES += gcc-or1knd-elf

GCC_OR1KND_ELF_TARGET:=or1k-elf

else

# Rules for packages
$(GCC_OR1KND_ELF_OR1K_SRC_PKG) : 
	$(Q)$(MK_PKG_SRC_DIR)
	$(Q)echo "Download $(GCC_OR1KND_ELF_OR1K_SRC_URL)"
	$(Q)$(WGET) -O $@ $(GCC_OR1KND_ELF_OR1K_SRC_URL)
	
$(GCC_OR1KND_ELF_OR1K_GCC_PKG) : 
	$(Q)$(MK_PKG_SRC_DIR)
	$(Q)echo "Download $(GCC_OR1KND_ELF_OR1K_GCC_URL)"
	$(Q)$(WGET) -O $@ $(GCC_OR1KND_ELF_OR1K_GCC_URL)
	
$(GCC_OR1KND_ELF_NEWLIB_PKG) : 
	$(Q)$(MK_PKG_SRC_DIR)
	$(Q)echo "Download $(GCC_OR1KND_ELF_NEWLIB_SRC_URL)"
	$(Q)$(WGET) -O $@ $(GCC_OR1KND_ELF_NEWLIB_SRC_URL)
	
$(GCC_OR1KND_ELF_GMP_PKG) : 
	$(Q)$(MK_PKG_SRC_DIR)
	$(Q)echo "Download $(GCC_OR1KND_ELF_GMP_SRC_URL)"
	$(Q)$(WGET) -O $@ $(GCC_OR1KND_ELF_GMP_SRC_URL)
	
$(GCC_OR1KND_ELF_MPFR_PKG) : 
	$(Q)$(MK_PKG_SRC_DIR)
	$(Q)echo "Download $(GCC_OR1KND_ELF_MPFR_SRC_URL)"
	$(Q)$(WGET) -O $@ $(GCC_OR1KND_ELF_MPFR_SRC_URL)
	
$(GCC_OR1KND_ELF_MPC_PKG) : 
	$(Q)$(MK_PKG_SRC_DIR)
	$(Q)echo "Download $(GCC_OR1KND_ELF_MPC_SRC_URL)"
	$(Q)$(WGET) -O $@ $(GCC_OR1KND_ELF_MPC_SRC_URL)
	
$(GCC_OR1KND_ELF_BINUTILS_PKG) : 
	$(Q)$(MK_PKG_SRC_DIR)
	$(Q)echo "Download $(GCC_OR1KND_ELF_BINUTILS_SRC_URL)"
	$(Q)$(WGET) -O $@ $(GCC_OR1KND_ELF_BINUTILS_SRC_URL)

GCC_OR1KND_ELF_PKG_DEPS := $(GCC_OR1KND_ELF_OR1K_SRC_PKG) \
  $(GCC_OR1KND_ELF_OR1K_GCC_PKG) \
  $(GCC_OR1KND_ELF_NEWLIB_PKG)   \
  $(GCC_OR1KND_ELF_GMP_PKG)      \
  $(GCC_OR1KND_ELF_GMP_PKG)      \
  $(GCC_OR1KND_ELF_MPFR_PKG)     \
  $(GCC_OR1KND_ELF_MPC_PKG)      \
  $(GCC_OR1KND_ELF_BINUTILS_PKG)

$(GCC_OR1KND_ELF_PKG) : $(BUILD_DIR)/gcc-or1knd-elf.build
	$(Q)echo "Copying GCC or1k Result Files"
	$(Q)rm -rf $(GCC_OR1KND_ELF_PKG_DIR)
	$(Q)mkdir -p $(GCC_OR1KND_ELF_PKG_DIR)
	$(Q)mkdir -p $(GCC_OR1KND_ELF_PKG_DIR)/usr
	$(Q)cp -r $(BUILD_DIR)/gcc-or1knd-elf/installdir/* $(GCC_OR1KND_ELF_PKG_DIR)/usr
	$(Q)echo "Packing $@"
	$(Q)cd $(GCC_OR1KND_ELF_PKG_DIR) ; $(TARBZ) $@ *
	$(Q)rm -rf $(GCC_OR1KND_ELF_PKG_DIR)
	

$(BUILD_DIR)/gcc-or1knd-elf/binutils.build : $(GCC_OR1KND_ELF_BINUTILS_PKG)
	$(Q)$(MKDIRS)
	$(Q)mkdir -p $(BUILD_DIR)/gcc-or1knd-elf
	$(Q)echo "Unpacking binutils"
	$(Q)rm -rf $(BUILD_DIR)/gcc-or1knd-elf/binutils-2.25
	$(Q)cd $(BUILD_DIR)/gcc-or1knd-elf; $(UNTARBZ2) $^
	$(Q)echo "Configuring binutils"
	$(Q)cd $(BUILD_DIR)/gcc-or1knd-elf/binutils-2.25 ; \
	  ./configure --prefix=$(BUILD_DIR)/gcc-or1knd-elf/installdir \
	    --target=$(GCC_OR1KND_ELF_TARGET) --disable-tcl --disable-tk \
	    --disable-itcl --disable-gdbtk --disable-winsup --disable-libgui \
	    --disable-rda --disable-sid --disable-sim --with-sysroot
	$(Q)cd $(BUILD_DIR)/gcc-or1knd-elf/binutils-2.25 ; $(MAKE) 
	$(Q)cd $(BUILD_DIR)/gcc-or1knd-elf/binutils-2.25 ; $(MAKE) install
	$(Q)rm -rf $(BUILD_DIR)/gcc-or1knd-elf/binutils-2.25
	$(Q)touch $@
	
$(BUILD_DIR)/gcc-or1knd-elf/gcc_phase1.build : \
		$(BUILD_DIR)/gcc-or1knd-elf/binutils.build \
		$(GCC_OR1KND_ELF_OR1K_GCC_PKG)
	$(Q)$(MKDIRS)
	$(Q)echo "Unpacking or1k-gcc (gcc)"
	$(Q)rm -rf $(BUILD_DIR)/gcc-or1knd-elf/or1k-gcc-or1k
	$(Q)cd $(BUILD_DIR)/gcc-or1knd-elf ; $(UNZIP) $(GCC_OR1KND_ELF_OR1K_GCC_PKG)
	$(Q)echo "Configuring GCC"
	$(Q)rm -rf $(BUILD_DIR)/gcc-or1knd-elf/gcc
	$(Q)mkdir $(BUILD_DIR)/gcc-or1knd-elf/gcc
	$(Q)cd $(BUILD_DIR)/gcc-or1knd-elf/gcc ; \
	    export PATH="$(BUILD_DIR)/gcc-or1knd-elf/installdir/bin:$(PATH)"; \
	    export ac_cv_sizeof_int=4 ; \
	    export ac_cv_sizeof_long=4 ; \
	    export ac_cv_sizeof_long_long=8 ; \
	    export ac_cv_sizeof_short=2 ; \
	    ../or1k-gcc-or1k/configure --target=$(GCC_OR1KND_ELF_TARGET) \
	    --prefix=$(BUILD_DIR)/gcc-or1knd-elf/installdir \
	    --enable-languages=c --disable-shared --disable-libssp
	$(Q)cd $(BUILD_DIR)/gcc-or1knd-elf/gcc ; \
	    export PATH="$(BUILD_DIR)/gcc-or1knd-elf/installdir/bin:$(PATH)"; $(MAKE)
	$(Q)cd $(BUILD_DIR)/gcc-or1knd-elf/gcc ; \
	    export PATH="$(BUILD_DIR)/gcc-or1knd-elf/installdir/bin:$(PATH)"; $(MAKE) install
	$(Q)rm -rf $(BUILD_DIR)/gcc-or1knd-elf/gcc
	$(Q)touch $@

$(BUILD_DIR)/gcc-or1knd-elf/newlib.build : \
	$(BUILD_DIR)/gcc-or1knd-elf/gcc_phase1.build \
	$(GCC_OR1KND_ELF_NEWLIB_PKG)
	$(Q)echo "Unpacking newlib"
	$(Q)rm -rf $(BUILD_DIR)/gcc-or1knd-elf/newlib-2.2.0.20150225
	$(Q)cd $(BUILD_DIR)/gcc-or1knd-elf ; $(UNTARGZ) $(GCC_OR1KND_ELF_NEWLIB_PKG)
	$(Q)echo "Configuring newlib"
	$(Q)cd $(BUILD_DIR)/gcc-or1knd-elf/newlib-2.2.0.20150225 ; \
	    export PATH="$(BUILD_DIR)/gcc-or1knd-elf/installdir/bin:$(PATH)"; \
	    ./configure --prefix=$(BUILD_DIR)/gcc-or1knd-elf/installdir \
	      --target=$(GCC_OR1KND_ELF_TARGET) 
	$(Q)echo "Building newlib"
	$(Q)cd $(BUILD_DIR)/gcc-or1knd-elf/newlib-2.2.0.20150225 ; \
	    export PATH="$(BUILD_DIR)/gcc-or1knd-elf/installdir/bin:$(PATH)"; $(MAKE) 
	$(Q)echo "Installing newlib"
	$(Q)cd $(BUILD_DIR)/gcc-or1knd-elf/newlib-2.2.0.20150225 ; \
	    export PATH="$(BUILD_DIR)/gcc-or1knd-elf/installdir/bin:$(PATH)"; $(MAKE) install
	$(Q)rm -rf $(BUILD_DIR)/gcc-or1knd-elf/newlib-2.2.0.20150225
	$(Q)touch $@
	
$(BUILD_DIR)/gcc-or1knd-elf/gcc_phase2.build : \
	$(BUILD_DIR)/gcc-or1knd-elf/newlib.build 
	$(Q)rm -rf $(BUILD_DIR)/gcc-or1knd-elf/gcc-phase2
	$(Q)mkdir -p $(BUILD_DIR)/gcc-or1knd-elf/gcc-phase2
	$(Q)cd $(BUILD_DIR)/gcc-or1knd-elf/gcc-phase2; \
	  ../or1k-gcc-or1k/configure --target=$(GCC_OR1KND_ELF_TARGET) \
	    --prefix=$(BUILD_DIR)/gcc-or1knd-elf/installdir \
	    --enable-languages=c,c++ --disable-shared --disable-libssp --with-newlib
	$(Q)echo "Building gcc phase2"
	$(Q)cd $(BUILD_DIR)/gcc-or1knd-elf/gcc-phase2; \
	    export PATH="$(BUILD_DIR)/gcc-or1knd-elf/installdir/bin:$(PATH)"; $(MAKE) 
	$(Q)echo "Installing gcc phase2"
	$(Q)cd $(BUILD_DIR)/gcc-or1knd-elf/gcc-phase2; \
	    export PATH="$(BUILD_DIR)/gcc-or1knd-elf/installdir/bin:$(PATH)"; $(MAKE) install
	$(Q)rm -rf $(BUILD_DIR)/gcc-or1knd-elf/gcc-phase2
	$(Q)touch $@
	
$(BUILD_DIR)/gcc-or1knd-elf.build : \
		$(BUILD_DIR)/gcc-or1knd-elf/gcc_phase1.build \
		$(BUILD_DIR)/gcc-or1knd-elf/newlib.build     \
		$(BUILD_DIR)/gcc-or1knd-elf/gcc_phase2.build 
	$(Q)touch $@
	
gcc-or1knd-elf : $(GCC_OR1KND_ELF_PKG)

endif
