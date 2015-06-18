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

  attribute(:port, kind_of: Integer, default: 6667)
  attribute(:broker_id, kind_of: [String, Integer], required: true)
  attribute(:log_dirs, kind_of: String, default: '/var/tmp/kafka')

  attribute(:options, option_collector: true, default: {})

  # @see https://kafka.apache.org/08/configuration.html
  def to_s
    options.merge(
      'broker.id' => broker_id,
      'port' => port,
      'log.dirs' => log_dirs).map { |v| v.join('=') }.join("\n")
  end

  action(:create) do
    notifying_block do
      directory ::File.dirname(new_resource.path) do
        recursive true
        mode '0754'
      end

      file new_resource.path do
        content new_resource.to_s
        mode '0640'
        owner new_resource.user
        group new_resource.group
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
