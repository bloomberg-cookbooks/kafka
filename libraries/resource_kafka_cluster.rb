#
# Cookbook: kafka-cluster-cookbook
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
class Chef::Resource::KafkaCluster < Chef::Resource::LWRP
  include Poise

  actions(:create, :remove)
  default_action(:create)

  attribute(:cluster_name,
    kind_of: String,
    name_attribute: true,
    required: true,
    cannot_be: :empty)
  attribute(:cluster_broker_id,
    kind_of: Integer,
    default: lazy { node['zookeeper-cluster']['cluster_broker_id'] })
end
