#
# Cookbook: kafka-cluster
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
include_recipe 'selinux::disabled'

node.default['java']['jdk_version'] = '8'
node.default['java']['accept_license_agreement'] = true
include_recipe 'java::default'

node.default['sysctl']['params']['vm']['swappiness'] = 0
include_recipe 'sysctl::apply'

poise_service_user node['kafka-cluster']['service_user'] do
  group node['kafka-cluster']['service_group']
end

user_ulimit node['kafka-cluster']['service_user'] do
  filehandle_limit 32_768
  notifies :restart, "kafka_service[#{node['kafka-cluster']['service_name']}]", :delayed
end

# set 'KAFKA_LOG4J_OPTS' if nodee['kafka-cluster']['config']['log4j']['customized'] is true
if node['kafka-cluster']['config']['log4j']['customized']
  config_directory = ::File.dirname(node['kafka-cluster']['config']['path'])
  log4j_config = ::File.join(config_directory, 'log4j.properties')
  node.default['kafka-cluster']['service']['environment']['KAFKA_LOG4J_OPTS'] = "-Dlog4j.configuration=file:#{log4j_config}"
end

kafka_config node['kafka-cluster']['service_name'] do |r|
  owner node['kafka-cluster']['service_user']
  group node['kafka-cluster']['service_group']

  node['kafka-cluster']['config'].each_pair { |k, v| r.send(k, v) }
  notifies :restart, "kafka_service[#{node['kafka-cluster']['service_name']}]", :delayed
end

kafka_service node['kafka-cluster']['service_name'] do |r|
  user node['kafka-cluster']['service_user']
  group node['kafka-cluster']['service_group']
  config_path node['kafka-cluster']['config']['path']
  data_dir node['kafka-cluster']['config']['properties']['log.dirs']

  node['kafka-cluster']['service'].each_pair { |k, v| r.send(k, v) }
end
