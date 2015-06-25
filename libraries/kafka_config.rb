#
# Cookbook: kafka-cluster
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
require 'poise'

# Resource for managing the Kafka configuration.
# @since 1.0.0
class Chef::Resource::KafkaConfig < Chef::Resource
  include Poise(fused: true)
  provides(:kafka_config)

  attribute(:path, kind_of: String, name_attribute: true, cannot_be: :empty)
  attribute(:user, kind_of: String, default: 'kafka', cannot_be: :empty)
  attribute(:group, kind_of: String, default: 'kafka', cannot_be: :empty)

  attribute(:properties, option_collector: true, default: {})

  # Outputs the +properties+ in the Java Properties file format. This is
  # what Kafka daemon consumes to tweak its internal configuration.
  def to_s
    properties.merge({}) do |k, o, n|
      n = if o.kind_of?(Array)
            o.flatten.map(&:to_s).join(',')
          else
            o
          end
    end.map { |kv| kv.join('=') }.join("\n")
  end

  action(:create) do
    notifying_block do
      directory ::File.dirname(new_resource.path) do
        recursive true
        mode '0755'
      end

      file new_resource.path do
        content new_resource.to_s
        mode '0644'
      end
    end
  end

  action(:delete) do
    notifying_block do
      file new_resource.path do
        action :delete
      end
    end
  end
end
