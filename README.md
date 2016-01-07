# kafka-cluster-cookbook
[![Build Status](https://img.shields.io/travis/bloomberg/kafka-cookbook.svg)](https://travis-ci.org/bloomberg/kafka-cookbook)
[![Code Quality](https://img.shields.io/codeclimate/github/bloomberg/kafka-cookbook.svg)](https://codeclimate.com/github/bloomberg/kafka-cookbook)
[![Cookbook Version](https://img.shields.io/cookbook/v/kafka-cluster.svg)](https://supermarket.chef.io/cookbooks/kafka-cluster)
[![License](https://img.shields.io/badge/license-Apache_2-blue.svg)](https://www.apache.org/licenses/LICENSE-2.0)

[Application cookbook][0] which installs and configures
[Apache Kafka][1].

Apache Kafka is publish-subscribe messaging rethought as a distributed
commit log. This cookbook takes a simplified approach towards
configuring and installing Apache Kafka.

It is important to note that [Apache Zookeeper][10] is a required
component of deploying an Apache Kafka cluster. We have developed a
[Zookeeper cluster cookbook][11] which takes the same simplified
approach and works seamlessly here.

## Basic Usage
This cookbook was designed from the ground up to make it dead simple
to install and configure an Apache Kafka cluster using Chef. It also
highlights several of our best practices for developing reusable Chef
cookbooks at Bloomberg.

This cookbook provides [node attributes](attributes/default.rb) which
can be used to fine tune the default recipe which installs and
configures Kafka. The values from the node attributes are passed
directly into the configuration and service resources.

Out of the box the following platforms are certified to work and
are tested using our [Test Kitchen][8] configuration. Additional platforms
_may_ work, but your mileage may vary.
- CentOS (RHEL) 6.6, 7.1
- Ubuntu 12.04, 14.04

The correct way to use this cookbook is to create a [wrapper cookbook][2]
which configures all of the members of the Apache Kafka cluster. This
includes reading the Zookeeper ensemble (cluster) configuration and passing
that into Kafka as a parameter. In this example we use our [Zookeeper Cluster
cookbook][11] to configure the ensemble on the same nodes.
```ruby
bag = data_bag_item('config', 'zookeeper-cluster')[node.chef_environment]
node.default['zookeeper-cluster']['config']['instance_name'] = node['ipaddress']
node.default['zookeeper-cluster']['config']['ensemble'] = bag['ensemble']
include_recipe 'zookeeper-cluster::default'

node.default['kafka-cluster']['config']['properties']['broker.id'] = node['ipaddress'].rpartition('.').last
node.default['kafka-cluster']['config']['properties']['zookeeper.connect'] = bag['ensemble'].map { |m| "#{m}:2181"}.join(',').concat('/kafka')
include_recipe 'kafka-cluster::default'
```

In the above example the Zookeeper ensemble configuration is read in
from a data bag. This is our suggested method for deploying using our
[Zookeeper Cluster cookbook][11]. But if you already have your
Zookeeper ensemble feel free to format the string _zookeeper.connect_
string appropriately.

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
