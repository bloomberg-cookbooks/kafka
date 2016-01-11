require 'poise_boiler/spec_helper'
require_relative '../../../libraries/kafka_topic'

describe KafkaClusterCookbook::Resource::KafkaTopic do
  step_into(:kafka_topic)
  context '#action_create' do
    before do
      stub_command('kafka-topics.sh --list --zookeeper localhost:2181/kafka | grep -w test').and_return(false)
    end
    recipe do
      kafka_topic 'test' do
        zookeeper 'localhost:2181/kafka'
      end
    end

    it { is_expected.to run_execute('kafka-topics.sh --create --topic test --zookeeper localhost:2181/kafka --partitions 1 --replication-factor 1') }
  end

  context '#action_delete' do
    before do
      stub_command('kafka-topics.sh --list --zookeeper localhost:2181/kafka | grep -w test').and_return(true)
    end
    recipe do
      kafka_topic 'test' do
        zookeeper 'localhost:2181/kafka'
        action :delete
      end
    end

    it { is_expected.to run_execute('kafka-topics.sh --delete --topic test --zookeeper localhost:2181/kafka --partitions 1') }
  end

  context '#action_update' do
    before do
      stub_command('kafka-topics.sh --list --zookeeper localhost:2181/kafka | grep -w test').and_return(true)
    end
    recipe do
      kafka_topic 'test' do
        zookeeper 'localhost:2181/kafka'
        action :update
      end
    end

    it { is_expected.to run_execute('kafka-topics.sh --alter --topic test --zookeeper localhost:2181/kafka --partitions 1') }
  end
end
