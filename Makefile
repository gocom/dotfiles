.PHONY: all build lint unit test package

all:
	@$(MAKE) test

build:
	bin/dotfiles docs

lint:
	bin/dotfiles lint

unit:
	bin/dotfiles unit

test:
	@$(MAKE) lint
	@$(MAKE) unit

package:
	mkdir -p dist
	rm -f dist/dotfiles.zip
	zip --symlinks -r dist/dotfiles.zip bin/ home/ lib/ platform/ share/ .editorconfig Aptfile Atomfile Brewfile composer.json Gemfile LICENSE Makefile package.json README.md
