## ---------- UTILS
.PHONY: help
help: ## Show this menu
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: clean
clean: ## Clean all temp files
	@rm -rf tmp

.PHONY: load_env
load_env: ## load env-vars from .env
	$(eval include .env)
	$(eval export)



## ---------- SETUP
.PHONY: setup
setup:
	go install github.com/cosmtrek/air@latest
	go mod tidy



## ---------- MAIN
.PHONY: build
build:
	@docker build -f docker/Dockerfile -t aleroxac/gopportunities .

.PHONY: run
run: ## run the app locally, with live-reaload by air
	@air

.PHONY: up
up: load_env ## run compose containers
	@docker-compose -f docker/docker-compose.yaml up -d

.PHONY: down
down: ## remove compose containers
	@docker-compose -f docker/docker-compose.yaml down
	@pkill air
