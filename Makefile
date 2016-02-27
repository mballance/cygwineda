
include common/rules_defs.mk
include packages/*.mk


RULES:=true

all : 
	@echo "Available targets:"
	@echo "  all-pkgs    - build all packages"
	@echo "  core-pkgs   - build core packages"
	@echo "  list-pkgs   - list the availble packages"
	@echo "  <package>   - build specific package"
	@echo "  clean-all   - remove everything"
	@echo "  clean-pkg   - remove result packages"
	@echo "  clean-build - remove package builds"

all-pkgs : core-pkgs

core-pkgs : $(CORE_PACKAGE_RESULTS)

list-pkgs : 
	@echo "Core Packages:"
	@for pkg in $(CORE_PACKAGE_NAMES); do \
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
