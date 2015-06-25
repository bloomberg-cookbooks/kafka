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
default['kafka-cluster']['service']['binary_checksum'] = '89ede9ae0f51f7163c4140d8ab43fcedf8eb3066bb8058f3d97f75e9868899ce'
default['kafka-cluster']['service']['binary_url'] = "http://mirror.cc.columbia.edu/pub/software/apache/kafka/%{version}/kafka_2.10-%{version}.tgz"
