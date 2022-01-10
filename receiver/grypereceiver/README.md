# Grype Receiver

[Grype](https://github.com/anchore/grype) is an _Open Source_ vulnerability scanner
for container images and filesystems written in _Go_. It works with [Syft](https://github.com/anchore/syft),
the powerful SBOM tool.

The receiver produces metrics data containing found vulnerabilities with these attributes:

* Package ID
* Package Name
* Package Version
* Package Language
* Package PURL
* Package Type
* Package Locations
* Vulnerability ID
* Vulnerability Namespace
* Vulnerability Severity
* Vulnerability Data Source
* Vulnerability Description

Let's see an example output:

```txt

```

## Configuration

### Required

 * `include`: List of paths to scan.

### Optional

 * `collection_interval` (default = `24h`): Scan for vulnerabilities on this interval.

### Example

```yaml
reveivers:
  grype:
    collection_interval: 12h
    include:
      - /opt/
      - /home/app
```

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