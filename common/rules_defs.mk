
ifneq (true,$(RULES))

ifeq (,$(VERBOSE))
VERBOSE:=false
endif

ifneq (true,$(VERBOSE))
VERBOSE:=false
endif

ifneq (true,$(VERBOSE))
Q:=@
endif


ifeq (true,$(VERBOSE))
UNZIP=unzip -o
WGET=wget
UNTARGZ=tar xvzf
TARBZ=tar cjvf
else
UNZIP=unzip -oq
WGET=wget -nv
UNTARGZ=tar xzf
TARBZ=tar cjf
endif

ROOT_DIR=$(shell pwd)
BUILD_DIR=$(ROOT_DIR)/build
PKG_SRC_DIR=$(ROOT_DIR)/package_src
PKG_DIR=$(ROOT_DIR)/packages
PKG_RESULT_DIR=$(ROOT_DIR)/package_result
else # Rules

$(BUILD_DIR) :
	$(Q)mkdir -p $(@)
	
$(PKG_SRC_DIR) : 
	$(Q)mkdir -p $(@)
	
$(PKG_RESULT_DIR) :
	$(Q)mkdir -p $(@)

MKDIRS = $(BUILD_DIR) $(PKG_SRC_DIR) $(PKG_RESULT_DIR)

endif