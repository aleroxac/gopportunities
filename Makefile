## ---------- VARIABLES
default: help


## ---------- VARIABLES
APP_NAME=gopportunities


## ---------- UTILS
.PHONY: help
help: ## Show this menu
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-10s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: clean
clean: ## Clean all temp files
	@rm -rf tmp db/*.db



## ---------- HELPERS
.PHONY: load-env
load-env: 
	$(eval include .env)
	$(eval export)



## ---------- SETUP
.PHONY: setup
setup: ## setup all dependencies
	@go install github.com/cosmtrek/air@latest
	@go install github.com/swaggo/swag/cmd/swag@latest
	@go mod tidy



## ---------- MAIN
.PHONY: build
build: ## build the container image
	@docker build -f docker/Dockerfile -t aleroxac/$(APP_NAME) .

.PHONY: docs
docs:
	@swag init


.PHONY: run
run: ## run the app locally
	@go run main.go

.PHONY: run-with-docs
run-with-docs: docs ## build docs and run the app locally
	@go run main.go


.PHONY: air
air: ## run the app locally, with live-reaload by air
	@air

.PHONY: air-with-docs
air-with-docs: docs ## build docs and run the app locally, with live-reaload by air
	@air



.PHONY: up
up: load-env docs ## run compose containers
	@docker-compose -f docker/docker-compose.yaml up -d

.PHONY: down
down: ## remove compose containers
	@docker-compose -f docker/docker-compose.yaml down
	@pkill air
