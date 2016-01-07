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
      attribute(:log4j,
                option_collector: true,
                default: {
                  'customized' => false,
                  'fileAppender' => 'org.apache.log4j.RollingFileAppender',
                  'maxFileSize' => '50MB',
                  'maxNumFiles' => '20',
                  'level' => {
                    'root' => 'INFO',
                    'kafka' => 'INFO',
                    'kafka.network.RequestChannel' => 'WARN',
                    'kafka.network.Processor' => 'WARN',
                    'kafka.request.logger' => 'WARN',
                    'kafka.controller' => 'TRACE',
                    'kafka.log.LogCleaner' => 'INFO',
                    'state.change.logger' => 'TRACE'
                  }
                })

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
        config_directory = ::File.dirname(new_resource.path)
        notifying_block do
          directory config_directory do
            mode '0755'
          end

          file new_resource.path do
            content new_resource.to_s
            mode '0644'
          end

          template ::File.join(config_directory, 'log4j.properties') do
            source 'log4j.properties.erb' # TODO: support replacing template by defining [config][log4j][source].
            owner new_resource.owner
            group new_resource.group
            mode '0644'
            variables(
              loggerLevelRoot: new_resource.log4j['level']['root'],
              loggerLevelKafka: new_resource.log4j['level']['kafka'],
              loggerLevelKafkaNetworkRequestChannel: new_resource.log4j['level']['kafka.network.RequestChannel'],
              loggerLevelKafkaNetworkProcessor: new_resource.log4j['level']['kafka.network.Processor'],
              loggerLevelKafkaRequestLogger: new_resource.log4j['level']['kafka.request.logger'],
              loggerLevelKafkaController: new_resource.log4j['level']['kafka.controller'],
              loggerLevelKafkaLogCleaner: new_resource.log4j['level']['kafka.log.LogCleaner'],
              loggerLevelStateChangeLogger: new_resource.log4j['level']['state.change.logger'],
              fileAppender: new_resource.log4j['fileAppender'],
              maxFileSize: new_resource.log4j['maxFileSize'],
              maxNumFiles: new_resource.log4j['maxNumFiles']
            )
            only_if { new_resource.log4j['customized'] }
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
