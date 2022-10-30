.PHONY: all build install link lint shell test test-unit package

DOTFILES_UID ?= "$$(id -u)"
DOTFILES_GID ?= "$$(id -g)"
RUN = docker-compose run -u "$(DOTFILES_UID):$(DOTFILES_GID)" --rm build

all: test

install: link build

link:
	bin/dotfiles install

build:
	$(RUN) bin/dotfiles build

lint:
	$(RUN) bin/dotfiles lint

shell:
	$(RUN) bash

test-unit:
	$(RUN) bin/dotfiles unit

test: lint test-unit

package:
	$(RUN) bin/dotfiles package

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
