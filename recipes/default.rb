#
# Cookbook: kafka-cluster-cookbook
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
node.default['java']['jdk_version'] = '7'
node.default['java']['accept_license_agreement'] = true
include_recipe 'java::default'

poise_service_user node['kafka-cluster']['username'] do
  group node['kafka-cluster']['groupname']
end

libartifact_file "kafka-#{node['kafka-cluster']['version']}" do
  artifact_name 'kafka'
  artifact_version node['kafka-cluster']['version']
  remote_url node['kafka-cluster']['remote_url'] % { version: artifact_version }
  remote_checksum node['kafka-cluster']['remote_checksum']
  owner node['kafka-cluster']['username']
  group node['kafka-cluster']['groupname']
end
