#
# Cookbook: kafka-cluster-cookbook
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#

# Zookeeper requires a unique, monotonic increasing identifier for all
# members in the cluster. Kafka requires the same.
node.default['zookeeper-cluster']['cluster_node_id'] = node['kafka-cluster']['cluster_broker_id']
include_recipe 'zookeeper-cluster::quorum'

kafka_cluster node['kafka-cluster']['cluster_name'] do
  cluster_broker_id node['kafka-cluster']['cluster_broker_id']
  action :create
end
