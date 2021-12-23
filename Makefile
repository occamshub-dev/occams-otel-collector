SHELL := /bin/bash
IMAGE_NAME ?= ccamshub/occamshub-otel-distr

.PHONY: all
all: build

.PHONY: clean
clean:
	@rm -rf build/*

.PHONY: deps
deps:
	@GO111MODULE=on go install go.opentelemetry.io/collector/cmd/builder@latest

.PHONY: build
build: deps
	@CGO_ENABLED=0 builder --config otelcol-builder.yaml --output-path=build

.PHONY: image
image: build
	@cp ./build/occamshub-otel-distr ./docker/otelcol
	@docker build -t ${IMAGE_NAME} ./docker
	@rm docker/otelcol
