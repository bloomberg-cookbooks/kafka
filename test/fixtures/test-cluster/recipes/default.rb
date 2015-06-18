node.default['zookeeper-cluster']['config']['ensemble'] = [ node['hostname'] ]
node.default['kafka-cluster']['config']['broker_id'] = node['ipaddress'].rpartition('.').last
node.default['kafka-cluster']['config']['zookeeper_connect'] = 'localhost:2181/kafka'
include_recipe 'kafka-cluster::default'
