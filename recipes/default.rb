#
# Cookbook: kafka-cluster-cookbook
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
node.default['java']['jdk_version'] = '7'
include_recipe 'java::default'

user = poise_service_user node['kafka-cluster']['username']
libartifact_file "kafka-#{node['kafka-cluster']['version']}" do
  artifact_name 'kafka'
  artifact_version node['kafka-cluster']['version']
  remote_url node['kafka-cluster']['remote_url'] % { version: artifact_version }
  remote_checksum node['kafka-cluster']['remote_checksum']
  owner user.name
  group user.group if user.group
end
