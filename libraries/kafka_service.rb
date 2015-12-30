#
# Cookbook: kafka-cluster
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
require 'poise_service/service_mixin'

module KafkaClusterCookbook
  module Resource
    # Resource for managing the Kafka service on an instance.
    # @since 1.0.0
    class KafkaService < Chef::Resource
      include Poise
      provides(:kafka_service)
      include PoiseService::ServiceMixin

      # @!attribute version
      # @return [String]
      attribute(:version, kind_of: String, required: true)

      # @!attribute install_method
      # @return [Symbol]
      attribute(:install_method, default: 'binary', equal_to: %w{binary package})

      # @!attribute install_path
      # @return [String]
      attribute(:install_path, kind_of: String, default: '/srv')

      # @!attribute user
      # @return [String]
      attribute(:user, kind_of: String, default: 'kafka')

      # @!attribute group
      # @return [String]
      attribute(:group, kind_of: String, default: 'kafka')

      # @!attribute environment
      # @return [String]
      attribute(:environment, kind_of: Hash, default: lazy { default_environment })

      # @!attribute package_name
      # @return [String]
      attribute(:package_name, kind_of: String, default: 'kafka')

      # @!attribute binary_url
      # @return [String]
      attribute(:binary_url, kind_of: String)

      # @!attribute binary_url
      # @return [String]
      attribute(:binary_checksum, kind_of: String)

      # @!attribute data_dir
      # @return [String]
      attribute(:data_dir, kind_of: String, default: '/var/lib/kafka')

      # @!attribute data_dir
      # @return [String]
      attribute(:log_dir, kind_of: String, default: '/var/log/kafka')

      # @!attribute config_filename
      # @return [String]
      attribute(:config_path, kind_of: String, default: '/etc/kafka/kafka.properties')

      def default_environment
        { PATH: '/usr/local/bin:/usr/bin:/bin' }
      end

      def current_path
        ::File.join(install_path, 'kafka', 'current', "kafka_2.10-#{version}")
      end

      def command
        ::File.join(current_path, "bin/kafka-server-start.sh #{config_path}")
      end
    end
  end

  module Provider
    # Provider for managing the Kafka service on an instance.
    # @since 1.0.0
    class KafkaService < Chef::Provider
      include Poise
      provides(:kafka_service)
      include PoiseService::ServiceMixin

      def action_enable
        notifying_block do
          package new_resource.package_name do
            version new_resource.version unless new_resource.version.nil?
            only_if { new_resource.install_method == 'package' }
          end

          libartifact_file "kafka-#{new_resource.version}" do
            artifact_name 'kafka'
            artifact_version new_resource.version
            install_path new_resource.install_path
            remote_url new_resource.binary_url % { version: new_resource.version }
            remote_checksum new_resource.binary_checksum
            only_if { new_resource.install_method == 'binary' }
          end

          new_resource.data_dir.split(',').each do |datadir|
            directory datadir do
              recursive true
              mode '0755'
              owner new_resource.user
              group new_resource.group
            end
          end

          directory new_resource.log_dir do
            recursive true
            mode '0755'
            owner new_resource.user
            group new_resource.group
          end
        end
        super
      end

      def action_disable
        notifying_block do
          directory new_resource.data_dir do
            action :delete
          end
        end
        super
      end

      def service_options(service)
        service.command(new_resource.command)
        service.directory(new_resource.current_path)
        service.user(new_resource.user)
        service.environment(new_resource.environment.merge(LOG_DIR: new_resource.log_dir))
        service.restart_on_update(true)
      end
    end
  end
end
