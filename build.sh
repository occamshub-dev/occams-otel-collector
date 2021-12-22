#!/bin/bash
GO111MODULE=on go install go.opentelemetry.io/collector/cmd/builder@latest
CGO_ENABLED=0 builder --config otelcol-builder.yaml --output-path=build
cp ./build/occamshub-otel-distr ./cmd/otelcol/otelcol
docker build -t occamshub-otel-distr ./cmd/otelcol
