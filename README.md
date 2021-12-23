# Occamshub OpenTelemetry Collector distribution

This repository contains the essentials to build the Occamshub distribution. With
this repo, you can build or even extend for your specific needs.

## Which components are included?

See [otelcol-builder.yaml](otelcol-builder.yaml) file to know which components are
included by default. If you want to include other components, edit the file and rebuild
the distribution.

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