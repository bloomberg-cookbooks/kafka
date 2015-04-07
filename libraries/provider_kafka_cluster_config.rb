#
# Cookbook: kafka-cluster-cookbook
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
require 'forwardable'

class Chef::Provider::KafkaClusterConfig < Chef::Provider::LWRP
  extend Forwardable
  def_delegators :@new_resource, :cluster_name

  use_inline_resources if defined?(use_inline_resources)
  provides :kafka_cluster_config

  def whyrun_enabled?
    true
  end

  action :create do

  end

  action :remove do

  end
end
