#
# Cookbook: kafka-cluster-cookbook
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
default['kafka-cluster']['cluster_name'] = 'kafka'

default['kafka-cluster']['username'] = 'kafka'
default['kafka-cluster']['groupname'] = 'kafka'

default['kafka-cluster']['init_type'] = :sysvinit
default['kafka-cluster']['version'] = '0.8.2.1'
default['kafka-cluster']['remote_checksum'] = 'a043655be6f3b6ec3f7eea25cc6525fd582da825972d3589b24912af71493a21'
default['kafka-cluster']['remote_url'] = "http://mirror.cc.columbia.edu/pub/software/apache/kafka/kafka-%{version}/kafka-%{version}-src.tgz"
