#
# Project targets
#
build: $(NODE_MODULES)
	./scripts/build.sh

clean: $(NODE_MODULES)
	./scripts/clean.sh

format: $(NODE_MODULES) 
	./scripts/format.sh

lint: $(NODE_MODULES)
	./scripts/lint.sh

test: $(NODE_MODULES)
	./scripts/test.sh

#
# Release targets
#
release:
	./scripts/release.sh

update-aur:
	./scripts/update-aur.sh

#
# Install targets
#
install:
	cd arch && rm -f *zst && makepkg -risc
