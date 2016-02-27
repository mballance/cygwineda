
include common/rules_defs.mk
include packages/*.mk


RULES:=true

all : 
	@echo "Available targets:"
	@echo "  build       - build all packages"
	@echo "  list_pkgs   - list the availble packages"
	@echo "  <package>   - build specific package"
	@echo "  clean-all   - remove everything"
	@echo "  clean-pkg   - remove result packages"
	@echo "  clean-build - remove package builds"

build : $(PACKAGE_RESULTS)

list_pkgs : 
	@echo "Available Packages:"
	@for pkg in $(PACKAGE_NAMES); do \
	echo "  $$pkg"; \
	done


include packages/*.mk
include common/rules_defs.mk


clean-all : clean-pkg clean-build clean-src

clean-src : 
	$(Q)rm -rf $(PKG_SRC_DIR)
	
clean-build :
	$(Q)rm -rf $(BUILD_DIR)
	
clean-pkg :
	$(Q)rm -rf $(PKG_RESULT_DIR)
