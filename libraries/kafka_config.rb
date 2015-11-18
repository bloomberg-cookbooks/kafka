#
# Cookbook: kafka-cluster
# License: Apache 2.0
#
# Copyright 2015, Bloomberg Finance L.P.
#
require 'poise'

module KafkaClusterCookbook
  module Resource
    # Resource for managing the Kafka configuration.
    # @since 1.0.0
    class KafkaConfig < Chef::Resource
      include Poise(fused: true)
      provides(:kafka_config)

      attribute(:path, kind_of: String, name_attribute: true)
      attribute(:owner, kind_of: String, default: 'kafka')
      attribute(:group, kind_of: String, default: 'kafka')

      attribute(:properties, option_collector: true, default: {})

      # Outputs the +properties+ in the Java Properties file format. This is
      # what Kafka daemon consumes to tweak its internal configuration.
      def to_s
        p = properties.merge({}) do |_k, _o, n|
          if n.is_a?(Array)
            n.flatten.map(&:to_s).join(',')
          else
            n
          end
        end
        p.map { |kv| kv.join('=') }.join("\n")
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
  end
end
