.PHONY: all build install link lint shell test test-unit package

RUN = docker-compose run -u "$$(id -u):$$(id -g)" --rm build

all: test

install: link build

link:
	bin/dotfiles install

build:
	$(RUN) bin/dotfiles install-packages
	$(RUN) bin/dotfiles docs

lint:
	$(RUN) bin/dotfiles lint

shell:
	$(RUN) bash

test-unit:
	$(RUN) bin/dotfiles unit

test: lint test-unit

package:
	$(RUN) bash -c 'mkdir -p dist && rm -f dist/dotfiles.zip && zip --symlinks -r dist/dotfiles.zip bin/ home/ lib/ platform/ share/ .editorconfig Aptfile Brewfile composer.json Gemfile LICENSE Makefile package.json README.md'

help:
	@echo "Manage dotfiles"
	@echo ""
	@echo "Usage:"
	@echo "  $$ make [command]"
	@echo ""
	@echo "Commands:"
	@echo ""
	@echo "  $$ make build"
	@echo "  Builds dotfiles"
	@echo ""
	@echo "  $$ make install"
	@echo "  Install dotfiles"
	@echo ""
	@echo "  $$ make link"
	@echo "  Creates symbolic links"
	@echo ""
	@echo "  $$ make lint"
	@echo "  Lint code style"
	@echo ""
	@echo "  $$ make shell"
	@echo "  Login to build container"
	@echo ""
	@echo "  $$ make test"
	@echo "  Run linter unit tests"
	@echo ""
	@echo "  $$ make test-unit"
	@echo "  Run unit tests"
	@echo ""
	@echo "  $$ make package"
	@echo "  Package a distributable archive"
	@echo ""
