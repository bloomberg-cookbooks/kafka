#
# Cookbook: kafka-cluster-cookbook
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#

class Chef::Provider::KafkaCluster < Chef::Provider::LWRP
  include Poise

  use_inline_resources if defined?(use_inline_resources)
  provides :kafka_cluster_config

  action :create do
    kafka_cluster_config new_resource.cluster_name do
      cluster_broker_id new_resource.cluster_broker_id
      action :create
    end
  end

  action :remove do
    kafka_cluster_config new_resource.cluster_name do
      action :remove
    end
  end
end
