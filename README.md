# Occamshub OpenTelemetry Collector distribution

![Occamshub logo](assets/otel_occams_hub_black_horizontal.png)

## Overview

An __OpenTelemetry__ distribution,  not to be confused with a fork, is customized
version of an __OpenTelemetry__ component. A distribution is a wrapper around an
upstream __OpenTelemetry__ repository with some customizations.

This is a repository for these customizations. These contributions are
specifically developed for __Occamshub__ use cases and could be useful to 
other users too.

It also contains the essential tools and files to build the Occamshub distribution.

## Download

To download the binary, please go to [Releases](https://github.com/occamshub-dev/occamshub-otel-distr/releases)
page and download the latest version.

## Configuration

We provide a [sample configuration file](otel.yaml) for reference. If you want to
know more about how to configure the __Collector__, please, visit 
[Collector Docs](https://opentelemetry.io/docs/collector/).

If you want to see complete configuration options for specific __Occamshub__ component, you can
find it under [Receivers](#Receivers), [Processors](#Processors) or [Exporters](#Exporters)
section.

## Run

To start the collector, just provide the configuration file as a parameter, as in the
example below.

```bash
./occamshub-otel-distr --config otel.yaml
```


## Receivers

### Grype

[Grype](https://github.com/anchore/grype) is an _Open Source_ vulnerability scanner
for container images and filesystems written in _Go_. It works with [Syft](https://github.com/anchore/syft),
the powerful SBOM tool.

## Processors

 > No processors yet

## Exporters

 > No exporters yet

## Build your own

See [otelcol-builder.yaml](otelcol-builder.yaml) file to know which components are
included by default. If you want to include or exclude other components, edit the
file and rebuild the distribution.

## Pre-requisites

 * [Go](https://go.dev)
 * [Make](https://www.gnu.org/software/make/)
 * [Docker](https://www.docker.com/) (Optional: build docker image)

## Build binary

In order to build the OTEL Collector executable, just run this command:

```bash
make all
```

You will find generated source code and the binary in the `build` path.

## Build docker image

To create a docker image compatible with official OpenTelemetry images,
run this command:

```bash
IMAGE_NAME=occamshub-otelcol make image
```

You can change the image name to whatever you want.

## Useful links

* [OpenTelemetry Collector @ github.com](https://github.com/open-telemetry/opentelemetry-collector)
* [OpenTelemetry Collector Contrib @ github.com](https://github.com/open-telemetry/opentelemetry-collector-contrib)

## License

```txt
Copyright 2021 Occamshub Inc

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```