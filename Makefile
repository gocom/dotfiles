.PHONY: all build lint unit test

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
