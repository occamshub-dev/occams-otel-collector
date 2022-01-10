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

Let's see an example output for Log4Shell (CVE-2021-44228) vuln detected:

```txt
ResourceMetrics #0
Resource SchemaURL: https://opentelemetry.io/schemas/v1.5.0
Resource labels:
     -> host.name: STRING(myhostname.local)
     -> os.type: STRING(LINUX)
InstrumentationLibraryMetrics #0
InstrumentationLibraryMetrics SchemaURL: 
InstrumentationLibrary grype/vulnerability 0.1.2
Metric #0
Descriptor:
     -> Name: vulnerability
     -> Description: Vulnerability found
     -> Unit: u
     -> DataType: Sum
     -> IsMonotonic: false
     -> AggregationTemporality: AGGREGATION_TEMPORALITY_UNSPECIFIED
NumberDataPoints #0
Data point attributes:
     -> package.id: STRING(db0bed40b5b7dcef)
     -> package.name: STRING(log4j-web)
     -> package.version: STRING(2.14.1)
     -> package.language: STRING(java)
     -> package.licences: STRING()
     -> package.purl: STRING(pkg:maven/org.apache.logging.log4j/log4j-web@2.14.1)
     -> package.type: STRING(maven)
     -> package.locations: STRING(solr/server/lib/ext/log4j-web-2.14.1.jar)
     -> vulnerability.id: STRING(CVE-2021-44228)
     -> vulnerability.namespace: STRING(nvd)
     -> vulnerability.severity: STRING(critical)
     -> vulnerability.data_source: STRING(https://nvd.nist.gov/vuln/detail/CVE-2021-44228)
     -> vulnerability.description: STRING(Apache Log4j2 2.0-beta9 through 2.12.1 and 2.13.0 through 2.15.0 JNDI features used in configuration, log messages, and parameters do not protect against attacker controlled LDAP and other JNDI related endpoints. An attacker who can control log messages or log message parameters can execute arbitrary code loaded from LDAP servers when message lookup substitution is enabled. From log4j 2.15.0, this behavior has been disabled by default. From version 2.16.0, this functionality has been completely removed. Note that this vulnerability is specific to log4j-core and does not affect log4net, log4cxx, or other Apache Logging Services projects.)
StartTimestamp: 1970-01-01 00:00:00 +0000 UTC
Timestamp: 2022-01-10 09:18:02.115157407 +0000 UTC
Value: 1
```

## Configuration

### Required

 * `include`: List of paths to scan.

### Optional

 * `exclude`: (default = `[]`): List of paths to exclude (relative to include)
 * `collection_interval` (default = `24h`): Scan for vulnerabilities on this interval.

### Example

```yaml
reveivers:
  grype:
    collection_interval: 12h
    include:
      - /opt/
      - /home/app
    exclude:
      - "**/*.log"
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