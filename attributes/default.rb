#
# Cookbook: kafka-cluster-cookbook
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
default['kafka-cluster']['service_name'] = 'kafka'
default['kafka-cluster']['service_user'] = 'kafka'
default['kafka-cluster']['service_group'] = 'kafka'

# @see https://gist.github.com/jkreps/c7ddb4041ef62a900e6c
default['kafka-cluster']['config']['path'] = '/etc/kafka/kafka.cfg'
default['kafka-cluster']['config']['properties']['broker.id'] = 1
default['kafka-cluster']['config']['properties']['port'] = 9092
default['kafka-cluster']['config']['properties']['num.partitions'] = 8
default['kafka-cluster']['config']['properties']['num.network.threads'] = 4
default['kafka-cluster']['config']['properties']['num.io.threads'] = 8
default['kafka-cluster']['config']['properties']['log_dirs'] = '/tmp/kafka'
default['kafka-cluster']['config']['properties']['log.retention.hours'] = 168
default['kafka-cluster']['config']['properties']['log.segment.bytes'] = 536870912
default['kafka-cluster']['config']['properties']['log.cleanup.interval.mins'] = 1
default['kafka-cluster']['config']['properties']['zookeeper.connection.timeout.ms'] = 1000000
default['kafka-cluster']['config']['properties']['socket.send.buffer.bytes'] = 1048576
default['kafka-cluster']['config']['properties']['socket.receive.buffer.bytes'] = 1048576
default['kafka-cluster']['config']['properties']['socket.request.max.bytes'] = 104857600
default['kafka-cluster']['config']['properties']['kafka.metrics.polling.interval.secs'] = 5
default['kafka-cluster']['config']['properties']['kafka.metrics.reporters'] = 'kafka.metrics.KafkaCSVMetricsReporter'
default['kafka-cluster']['config']['properties']['kafka.csv.metrics.dir'] = '/tmp/kafka_metrics'
default['kafka-cluster']['config']['properties']['kafka.csv.metrics.reporter.enabled'] = false
default['kafka-cluster']['config']['properties']['replica.lag.max.messages'] = 10000000

default['kafka-cluster']['service']['version'] = '0.8.2.1'
default['kafka-cluster']['service']['environment']['KAFKA_HEAP_OPTS'] = '-Xmx1G -Xms1G'
default['kafka-cluster']['service']['binary_checksum'] = '89ede9ae0f51f7163c4140d8ab43fcedf8eb3066bb8058f3d97f75e9868899ce'
default['kafka-cluster']['service']['binary_url'] = "http://mirror.cc.columbia.edu/pub/software/apache/kafka/%{version}/kafka_2.10-%{version}.tgz"
