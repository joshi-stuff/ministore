# Target dir for make install
PREFIX ?= /usr

# Shorthand variables
CP = cp -a --no-preserve=ownership 

#
# External targets
#
install: 
	mkdir -p "$(PREFIX)/bin"
	$(CP) bin/ministore "$(PREFIX)/bin/ministore"

	mkdir -p "$(PREFIX)/lib/git-core"
	$(CP) lib/git-core/git-credential-ministore "$(PREFIX)/lib/git-core/git-credential-ministore"

	mkdir -p "$(PREFIX)/lib/ministore"
	$(CP) lib/ministore/* "$(PREFIX)/lib/ministore"

uninstall:
	rm -f "$(PREFIX)/bin/ministore"

	rm -rf "$(PREFIX)/lib/git-core/git-credential-ministore"

	rm -rf "$(PREFIX)/lib/ministore"

release:
	./scripts/release
