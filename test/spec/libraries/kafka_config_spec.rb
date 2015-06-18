require 'spec_helper'

describe_recipe 'kafka-cluster::default' do
  cached(:chef_run) { ChefSpec::SoloRunner.new(step_into: %w{kafka_config}).converge(described_recipe) }
  context 'with default attributes' do
    it 'converges successfully' do
      chef_run
    end
  end
end
