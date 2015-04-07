#
# Cookbook: kafka-cluster-cookbook
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
default['kafka-cluster']['cluster_name'] = 'kafka'

default['kafka-cluster']['username'] = 'kafka'

default['kafka-cluster']['init_type'] = :sysvinit
default['kafka-cluster']['version'] = ''
default['kafka-cluster']['remote_checksum'] = ''
default['kafka-cluster']['remote_url'] = "http://mirror.cc.columbia.edu/pub/software/apache/kafka/kafka-%{version}/kafka-%{version}.tar.gz"
