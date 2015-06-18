#
# Cookbook: kafka-cluster-cookbook
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
default['kafka-cluster']['service_name'] = 'kafka'
default['kafka-cluster']['service_user'] = 'kafka'
default['kafka-cluster']['service_group'] = 'kafka'

default['kafka-cluster']['config']['path'] = '/etc/kafka/kafka.cfg'
default['kafka-cluster']['config']['broker_id'] = 1

default['kafka-cluster']['service']['version'] = '0.8.2.1'
default['kafka-cluster']['service']['environment']['KAFKA_HEAP_OPTS'] = '-Xmx1G -Xms1G'
default['kafka-cluster']['service']['binary_checksum'] = 'a043655be6f3b6ec3f7eea25cc6525fd582da825972d3589b24912af71493a21'
default['kafka-cluster']['service']['binary_url'] = "http://mirror.cc.columbia.edu/pub/software/apache/kafka/%{version}/kafka-%{version}-src.tgz"
