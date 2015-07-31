require 'poise_boiler/spec_helper'
require_relative '../../../libraries/kafka_config'

describe KafkaClusterCookbook::Resource::KafkaConfig do
  step_into(:kafka_config)
  context '#action_create' do
    recipe do
      kafka_config '/etc/kafka/kafka.properties'
    end

    it { is_expected.to create_directory('/etc/kafka') }
    it { is_expected.to create_file('/etc/kafka/kafka.properties') }
  end

  context '#action_delete' do
    recipe do
      kafka_config '/etc/kafka/kafka.properties' do
        action :delete
      end
    end

    it { is_expected.to delete_file('/etc/kafka/kafka.properties') }
  end
end
