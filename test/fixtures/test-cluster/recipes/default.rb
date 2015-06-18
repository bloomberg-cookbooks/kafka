node.default['zookeeper-cluster']['config']['ensemble'] = [ node['hostname'] ]
node.default['kafka-cluster']['config']['broker_id'] = node['ipaddress'].rpartition('.').last
include_recipe 'kafka-cluster::default'
