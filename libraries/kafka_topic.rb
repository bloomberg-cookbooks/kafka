#
# Cookbook: kafka-cluster
# License: Apache 2.0
#
# Copyright 2015, Bloomberg Finance L.P.
#
require 'poise'

module KafkaClusterCookbook
  module Resource
    # A resource for managing Kafka topics.
    # @since 1.2.0
    class KafkaTopic < Chef::Resource
      include Poise(fused: true)
      provides(:kafka_topic)
      actions(:create, :delete, :update)
      default_action(:create)

      attribute(:topic_name, kind_of: String, name_attribute: true)
      attribute(:zookeeper, kind_of: [Array, String], required: true)
      attribute(:replication_factor, kind_of: Integer, default: 1)
      attribute(:partitions, kind_of: Integer, default: 1)
      attribute(:environment, kind_of: Hash, default: lazy { default_environment })

      def command(type)
        ['kafka-topics.sh', "--#{type}"].tap do |c|
          c << ['--name', topic_name]
          c << ['--zookeeper', [zookeeper].compact.join(',')]
          c << ['--partitions', partitions] if partitions
          c << ['--replication-factor', replication_factor] if replication_factor
        end.flatten.join(' ')
      end

      def topic_exists?
        ['kafka-topics.sh --list', '--zookeeper', zookeeper, '| grep -i', topic_name].join(' ')
      end

      def default_environment
        { 'PATH' => '/srv/kafka/current/bin:/usr/bin:/bin' }
      end

      action(:create) do
        notifying_block do
          execute new_resource.command('create') do
            guard_interpreter :default
            environment new_resource.environment
            not_if new_resource.topic_exists?
          end
        end
      end

      action(:update) do
        notifying_block do
          execute new_resource.command('alter') do
            guard_interpreter :default
            environment new_resource.environment
            only_if new_resource.topic_exists?
          end
        end
      end

      action(:delete) do
        notifying_block do
          execute new_resource.command('delete') do
            guard_interpreter :default
            environment new_resource.environment
            only_if new_resource.topic_exists?
          end
        end
      end
    end
  end
end
