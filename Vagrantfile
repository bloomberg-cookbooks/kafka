fail unless Vagrant.has_plugin?('vagrant-berkshelf')
fail unless Vagrant.has_plugin?('vagrant-omnibus')
Vagrant.configure('2') do |config|
  config.berkshelf.enabled = true
  config.omnibus.chef_version = :latest

  if Vagrant.has_plugin?('vagrant-cachier')
    config.cache.scope = :box
  end

  config.vm.box = ENV.fetch('VAGRANT_VM_BOX', 'opscode-centos-6.6')
  config.vm.box_url = ENV.fetch('VAGRANT_VM_BOX_URL', 'http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-6.6_chef-provisionerless.box')

  # Quorum requires an odd number of instances and three seems like an
  # appropriate number to test with.
  3.times do |id|
    config.vm.define "kafka#{id}" do |guest|
      guest.vm.provision :chef_zero do |chef|
        chef.nodes_path = File.expand_path('../.vagrant/chef/nodes', __FILE__)
        chef.run_list = %w(kafka-cluster::cluster)
        chef.json = {
          'kafka-cluster' => {
            'config' => {
              'broker_id' => id
            }
          }
        }
      end
    end
  end
end
