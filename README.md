# kafka-cluster-cookbook
[Application cookbook][0] which installs and configures
[Apache Kafka][1].

Apache Kafka is publish-subscribe messaging rethought as a distributed
commit log. This cookbook takes a simplified approach towards
configuring and installing Apache Kafka.

It is important to note that [Apache Zookeeper][10] is a required
component of deploying an Apache Kafka cluster. We have developed a
[Zookeeper cluster cookbook][11] which takes the same simplified
approach and works seamlessly here.

## Platforms
This cookbook utilizies [Test Kitchen][8] to run unit and integration
tests. It is certified to run on the following platforms (these are
the ones which we test in our integration tests):
- CentOS >= 6.6 (RHEL)
- Ubuntu >= 12.04

## Dependencies
This cookbook has a few required dependencies which must be uploaded
to the Chef Server. Our preferred method of doing this is to simply
use `bin/berks upload`. We have included a simple table below with
descriptions on what parts of dependency cookbooks are used.

| Cookbook Name | Usage |
| ------------- | ----- |
| [libartifact][4] | [Library cookbook][3] which manages on-disk versions of release artifacts. |
| [Poise][5] | [Library cookbook][3] which provides reusable Chef patterns. |
| [Poise Service][6] | [Library cookbook][3] which provides reusable patterns for services. |
| [SELinux][7] | [Application cookbook][0] which configures SELinux. |

## Attributes
This cookbook provides node attributes which can be used to fine tune
how the default recipe configures the instance. These node attributes
are nested where `config/properties/tickTime` would be equivalent to
`node['kafka-cluster']['config']['properties']['broker.id']`.

Some of the more important properties below are shown with their default
values. These default properties were taken from the [Apache Kafka horse's
mouth][12], but obviously your mileage may vary.

| Name | Type | Default |
| ---- | ---- | ------- |
| config/path | String | /etc/kafka/kafka.properties |
| config/properties/broker.id | Integer | 1 |
| config/properties/port | Integer | 9092 |
| config/properties/num.partitions | Integer | 8 |
| config/properties/num.network.threads | Integer | 4 |
| config/properties/num.io.threads | Integer | 8 |
| config/properties/log.retention.hours | Integer | 168 |
| config/properties/log.segment.bytes | Integer | 536870912 |
| config/properties/zookeeper.connection.timeout.ms | Integer | 1000000 |

## Resources/Providers
This cookbook provides resource and provider primitives to manage
the Apache Kafka service locally on a node. These primitives
are what is used in the default recipe, and should be used in
your own [wrapper cookbooks][2].

### kafka_config
This resource is a Chef primitive which provides validation on top of
the [Apache Kafka service configuration][9]. It is meant to
provide a set of sane defaults and be configured using node attributes
through a [wrapper cookbook][2]. Some of the resource properties which
are made available (and are validated):

| Property | Type | Description | Default |
| -------- | ---- | ----------- | ------- |
| path | String | File system path where configuration is written. | name |
| owner | String | System username for configuration ownership. | kafka |
| group | String | System groupname for configuration ownership. | kafka |

### kafka_service
This resource is a Chef primitive which manages the lifecycle of the
Apache Kafka service on the node. Through the
[poise-service cookbook][6] it supports several different providers
for service initialization (e.g. sysvinit, systemd, upstart, etc).

| Property | Type | Description | Default |
| -------- | ---- | ----------- | ------- |
| version | String | Version of the Apache Kafka server. | 0.8.2.1 |
| install_method | String | Type of way to install Apache Kafka. | binary |
| install_path | String | Filesystem absolute path to install Apache Kafka. | /srv |
| user | String | System username which Apache Kafka service will run as. | kafka |
| group | String | System groupname which Apache Kafka service will run as. | kafka |
| config_path | String | Filesystem absolute path to the configuration. | /etc/kafka/kafka.properties |

[0]: http://blog.vialstudios.com/the-environment-cookbook-pattern/#theapplicationcookbook
[1]: http://kafka.apache.org/
[2]: http://blog.vialstudios.com/the-environment-cookbook-pattern#thewrappercookbook
[3]: http://blog.vialstudios.com/the-environment-cookbook-pattern#thelibrarycookbook
[4]: https://github.com/johnbellone/libartifact-cookbook
[5]: https://github.com/poise/poise
[6]: https://github.com/poise/poise-service
[7]: https://github.com/skottler/selinux
[8]: https://github.com/test-kitchen/test-kitchen
[9]: http://kafka.apache.org/documentation.html#brokerconfigs
[10]: https://zookeeper.apache.org
[11]: https://github.com/bloomberg/zookeeper-cookbook
[12]: https://engineering.linkedin.com/kafka/benchmarking-apache-kafka-2-million-writes-second-three-cheap-machines
