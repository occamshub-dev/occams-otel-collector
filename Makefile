SHELL := /bin/bash
IMAGE_NAME ?= occamshub/occams-otel-collector
GOBUILD = GO111MODULE=on CGO_ENABLED=0 installsuffix=cgo go build -trimpath
GOMOD ?= github.com/occamshub-dev/occams-otel-collector

.PHONY: all
all: build

.PHONY: clean
clean:
	@rm -rf cmd/occamscol/*
	@rm -rf build/*

.PHONY: deps
deps:
	@GO111MODULE=on go install go.opentelemetry.io/collector/cmd/builder@v0.43.0

.PHONY: vulns
vulns:
	@go get -d github.com/docker/distribution@v2.8.0
	@go get -d github.com/containerd/containerd@v1.5.10
	@go get -d github.com/hashicorp/go-getter@v1.5.11
	@go get -d github.com/opencontainers/runc@v1.0.3
	@go get -d github.com/nats-io/nats-server/v2@v2.2.0
	@go get -d github.com/buger/jsonparser@v1.0.0
	@go mod tidy

.PHONY: regen
regen: deps
	@ln -s ../../receiver ./cmd/occamscol/receiver
	@CGO_ENABLED=0 builder --config otelcol-builder.yaml --output-path=./cmd/occamscol --skip-compilation --module $(GOMOD)
	@mv ./cmd/occamscol/go.mod .
	@mv ./cmd/occamscol/go.sum .
	@rm ./cmd/occamscol/receiver

.PHONY: build
build:
	GOOS=linux GOARCH=amd64 $(GOBUILD) -o ./build/linux/occamscol_linux_x86_64 ./cmd/occamscol
	GOOS=linux GOARCH=arm64 $(GOBUILD) -o ./build/linux/occamscol_linux_arm64 ./cmd/occamscol
	GOOS=darwin GOARCH=amd64 $(GOBUILD) -o ./build/darwin/occamscol_darwin_x86_64 ./cmd/occamscol
	GOOS=darwin GOARCH=arm64 $(GOBUILD) -o ./build/darwin/occamscol_darwin_arm64 ./cmd/occamscol
	GOOS=windows GOARCH=amd64 EXTENSION=.exe $(GOBUILD) -o ./build/windows/occamscol_windows_amd64.exe ./cmd/occamscol
	@md5sum ./build/linux/occamscol_linux_x86_64 > ./build/checksums.txt
	@md5sum ./build/linux/occamscol_linux_arm64 >> ./build/checksums.txt
	@md5sum ./build/darwin/occamscol_darwin_x86_64 >> ./build/checksums.txt
	@md5sum ./build/darwin/occamscol_darwin_arm64 >> ./build/checksums.txt
	@md5sum ./build/windows/occamscol_windows_amd64.exe >> ./build/checksums.txt

.PHONY: docker-build
docker-build: build
	@cp ./cmd/occamscol/build/linux/occamscol_linux_x86_64 ./docker/otelcol
	@docker build -t ${IMAGE_NAME} ./docker
	@rm docker/otelcol
