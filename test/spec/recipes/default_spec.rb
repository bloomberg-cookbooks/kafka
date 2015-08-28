require 'spec_helper'

describe_recipe 'kafka-cluster::default' do
  cached(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  it { expect(chef_run).to include_recipe('selinux::disabled') }
  it { expect(chef_run).to include_recipe('java::default') }
  it { expect(chef_run).to include_recipe('sysctl::apply') }
  it { expect(chef_run).to create_poise_service_user('kafka').with(group: 'kafka') }
  it { expect(chef_run).to create_kafka_config('kafka') }
  it { expect(chef_run).to enable_kafka_service('kafka') }

  context 'with default attributes' do
    it 'converges successfully' do
      chef_run
    end
  end
end
