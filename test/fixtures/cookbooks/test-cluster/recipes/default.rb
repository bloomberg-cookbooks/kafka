node.default['zookeeper-cluster']['config']['ensemble'] = [ node['hostname'] ]
node.default['kafka-cluster']['config']['properties']['zookeeper.connect'] = 'localhost:2181/kafka'
include_recipe 'kafka-cluster::default'
