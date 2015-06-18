#
# Cookbook: kafka-cluster
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
include_recipe 'zookeeper-cluster::default'

node.default['sysctl']['params']['vm']['swappiness'] = 0
include_recipe 'sysctl::apply'

poise_service_user node['kafka-cluster']['service_user'] do
  group node['kafka-cluster']['service_group']
end

user_ulimit node['kafka-cluster']['service_user'] do
  filehandle_limit 32768
  notifies :restart, "kafka_service[#{node['kafka-cluster']['service_name']}]", :delayed
end

kafka_config node['kafka-cluster']['service_name'] do |r|
  user node['kafka-cluster']['service_user']
  group node['kafka-cluster']['service_group']

  node['kafka-cluster']['config'].each_pair { |k, v| r.send(k, v) }
  notifies :restart, "kafka_service[#{node['kafka-cluster']['service_name']}]", :delayed
end

kafka_service node['kafka-cluster']['service_name'] do |r|
  user node['kafka-cluster']['service_user']
  group node['kafka-cluster']['service_group']
  config_path node['kafka-cluster']['config']['path']

  node['kafka-cluster']['service'].each_pair { |k, v| r.send(k, v) }
  action [:enable, :start]
end
