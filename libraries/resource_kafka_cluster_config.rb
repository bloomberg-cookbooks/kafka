#
# Cookbook: kafka-cluster-cookbook
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
class Chef::Resource::KafkaClusterConfig < Chef::Resource::LWRP
  self.resource_name = :kafka_cluster_config

  attribute :cluster_name, kind_of: String, name_attribute: true, required: true
end
