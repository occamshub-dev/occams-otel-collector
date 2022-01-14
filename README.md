# Occamshub OpenTelemetry Collector distribution

![Occamshub logo](assets/otel_occams_hub_black_horizontal.png "OpenTelemetry + Occamshub")

## Overview

Occamshub OpenTelemetry Collector distribution (_OTEL Collector_), is an Occamshub
version of the upstream __OTEL Collector__ to send telemetry data, Metrics, Logs and
Trances to supported backends.

**What is the OTEL Collector?**

_OTEL Collector_ is a vendor-agnostic implementation to receive, process and export
telemetry data. It removes the need to maintain multiple agents/collectors, and
it can act as an agent or a collector.

![OTEL Collector](assets/otel-col.png "OTEL Collector overview")
*fig.1: [OTEL Collector figure](https://github.com/open-telemetry/opentelemetry.io/blob/main/iconography/Otel_Collector.svg) by [OpenTelemetry](https://opentelemetry.io/) is licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)*

**What is an OTEL Collector distribution?**

An __OTEL Collector__ distribution, not to be confused with a fork, is a customized
version of the __OTEL Collector__ . A distribution is a wrapper around
upstream __OTEL Collector__ repositories with some custom components added.

Here is a figure _(fig.2)_ that illustrates how this repository is extending the
__OTEL Collector__ in general terms.

![OTEL Collector](assets/occams-otel-col.png "OTEL Collector overview")
*fig.2: OTEL Collector can be extended without touching core code*

## Built-in components

This is the list for the included components of the distribution, referencing their
upstream repositories:

| Receiver                                | Processor                            | Exporter                 |
|-----------------------------------------|--------------------------------------|--------------------------|
| otlpreceiver (core)                     | batchprocessor (core)                | loggingexporter (core)   |
| prometheusreceiver (contrib)            | memorylimiterprocessor (core)        | otlpexporter (core)      |
| hostmetricsreceiver (contrib)           | attributesprocessor (contrib)        | otlphttpexporter (core)  |
| dockerstatsreceiver (contrib)           | resourcedetectionprocessor (contrib) | fileexporter (contrib)   |
| filelogreceiver (contrib)               |                                      | kafkaexporter (contrib)  |
| jaegerreceiver (contrib)                |                                      |                          |
| zipkinreceiver (contrib)                |                                      |                          |
| [grypereceiver](receiver/grypereceiver) |                                      |                          |

### Core components

* [OTLP Receiver](https://github.com/open-telemetry/opentelemetry-collector/tree/main/receiver/otlpreceiver)
* [Batch Processor](https://github.com/open-telemetry/opentelemetry-collector/tree/main/processor/batchprocessor)
* [Memory limiter Processor](https://github.com/open-telemetry/opentelemetry-collector/tree/main/processor/memorylimiterprocessor)
* [Logging Exporter](https://github.com/open-telemetry/opentelemetry-collector/tree/main/exporter/loggingexporter)
* [OTLP Exporter](https://github.com/open-telemetry/opentelemetry-collector/tree/main/exporter/otlpexporter)
* [OTLP HTTP Exporter](https://github.com/open-telemetry/opentelemetry-collector/tree/main/exporter/otlphttpexporter)
* [Jaeger Receiver](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/receiver/jaegerreceiver)
* [Zipkin Receiver](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/receiver/zipkinreceiver)

### Contrib components

* [Prometheus Receiver](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/receiver/prometheusreceiver)
* [Host metrics Recevier](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/receiver/hostmetricsreceiver)
* [Docker stats Receiver](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/receiver/dockerstatsreceiver)
* [File log Receiver](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/receiver/filelogreceiver)
* [Attributes Processor](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/processor/attributesprocessor)
* [Resource detection Processor](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/processor/resourcedetectionprocessor)
* [File Exporter](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/exporter/fileexporter)
* [Kafka Exporter](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/exporter/kafkaexporter)

### Custom components

* [Grype Receiver](receiver/grypereceiver). Periodically scans filesystem path/s for vulnerabilities using
  [Grype](https://github.com/anchore/grype), an _Open Source_ vulnerability scanner for container images and 
  filesystems written in _Go_. It acts as a scrapper, so there is no more input than the configuration.

## Usage

__Occamshub OTEL Collector distribution__ is meant to be used as an agent to collect your
telemetry data and export it to your preferred backend using any built-in exporter.

**Download**

To download the binary release, please go to [Releases](https://github.com/occamshub-dev/occamshub-otel-distr/releases)
page and download the latest version for OS and architecture of your choice.

**Configuration**

Configuration is set using a YAML file, as in any other _OTEL Collector_ distribution.
This settings file will define the data pipelines and the components used on those
pipelines. A sample config file [otel.yaml](otel.yaml) is also provided for reference
and testing purposes.

If you want to see complete configuration options for specific __Occamshub__ component, you can
find it under [Receivers](receiver), Processors or Exporters sections.

**Run**

To start the collector, just provide the configuration file as a parameter, as in the
example below.

```bash
./occamscol_linux_x86_64 --config otel.yaml
```

## Build

This section is for developers. Users looking to simply run the _OTEL Collector_ 
should check out [Usage](#Usage) section.

**Dependencies**

* [Go](https://go.dev)
* [Make](https://www.gnu.org/software/make/)
* [Docker](https://www.docker.com/) (Optional: build docker image)

**Compile**

In order to build the OTEL Collector executable, just run this command:

```bash
make all
```

You will find generated source code and the binary in the `build` path.

**Build docker image**

To create a docker image compatible with official OpenTelemetry images,
run this command:

```bash
IMAGE_NAME=occamshub-otelcol make docker-build
```
You can change the image name to whatever you want.

**Customize**

Checkout [otelcol-builder.yaml](otelcol-builder.yaml) file to know which components are
included by default. If you want to include or exclude components, edit this file and
run this command:

```bash
make regen build
```

In case you want to change some Occamshub component, you will need to add some replaces
as this at the end of the [otelcol-builder.yaml)](otelcol-builder.yaml) file:

```yaml
replaces:
  - github.com/occamshub-dev/occamshub-otel-distr/receiver/grypereceiver => ./receiver/grypereceiver
```

## Useful links

### Occamshub

* [Occamshub website](https://occamshub.com)
* [Occamshub blog](https://blog.occamshub.com)
* [Slack](https://occamshub.slack.com)

### External links

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