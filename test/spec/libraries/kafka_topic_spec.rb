require 'poise_boiler/spec_helper'
require_relative '../../../libraries/kafka_topic'

describe KafkaClusterCookbook::Resource::KafkaTopic do
  step_into(:kafka_topic)
  context '#action_create' do
    before do
      stub_command('kafka-topics.sh --list --zookeeper localhost:2181 | grep -i test').and_return(false)
    end
    recipe do
      kafka_topic 'test' do
        zookeeper 'localhost:2181'
      end
    end

    it { is_expected.to run_execute('kafka-topics.sh --create --name test --zookeeper localhost:2181 --partitions 1 --replication-factor 1') }
  end

  context '#action_delete' do
    before do
      stub_command('kafka-topics.sh --list --zookeeper localhost:2181 | grep -i test').and_return(true)
    end
    recipe do
      kafka_topic 'test' do
        zookeeper 'localhost:2181'
        action :delete
      end
    end

    it { is_expected.to run_execute('kafka-topics.sh --delete --name test --zookeeper localhost:2181 --partitions 1 --replication-factor 1') }
  end

  context '#action_update' do
    before do
      stub_command('kafka-topics.sh --list --zookeeper localhost:2181 | grep -i test').and_return(true)
    end
    recipe do
      kafka_topic 'test' do
        zookeeper 'localhost:2181'
        action :update
      end
    end

    it { is_expected.to run_execute('kafka-topics.sh --alter --name test --zookeeper localhost:2181 --partitions 1 --replication-factor 1') }
  end
end
