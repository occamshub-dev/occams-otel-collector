SHELL := /bin/bash
IMAGE_NAME ?= occamshub/occamshub-otel-distr
GOBUILD = GO111MODULE=on CGO_ENABLED=0 installsuffix=cgo go build -trimpath
GOMOD ?= github.com/occamshub-dev/occamshub-otel-distr

.PHONY: all
all: build

.PHONY: clean
clean:
	@rm -rf cmd/occamscol/*

.PHONY: deps
deps:
	@GO111MODULE=on go install go.opentelemetry.io/collector/cmd/builder@v0.42.0

.PHONY:
rebuild: deps
	@CGO_ENABLED=0 builder --config otelcol-builder.yaml --output-path=./cmd/occamscol --skip-compilation --module $(GOMOD)
	@mv ./cmd/occamscol/go.mod .
	@mv ./cmd/occamscol/go.sum .

.PHONY: build
build:
	GOOS=linux GOARCH=amd64 $(GOBUILD) -o ./build/linux/occamscol_linux_x86_64 ./cmd/occamscol
	GOOS=linux GOARCH=arm64 $(GOBUILD) -o ./build/linux/occamscol_linux_arm64 ./cmd/occamscol
	GOOS=darwin GOARCH=amd64 $(GOBUILD) -o ./build/darwin/occamscol_darwin_x86_64 ./cmd/occamscol
	GOOS=darwin GOARCH=arm64 $(GOBUILD) -o ./build/darwin/occamscol_darwin_arm64 ./cmd/occamscol
	GOOS=windows GOARCH=amd64 EXTENSION=.exe $(GOBUILD) -o ./build/windows/occamscol_windows_amd64 ./cmd/occamscol

.PHONY: image
image: build
	@cp ./cmd/occamscol/build/linux/occamscol_linux_x86_64 ./docker/otelcol
	@docker build -t ${IMAGE_NAME} ./docker
	@rm docker/otelcol
