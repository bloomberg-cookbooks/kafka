#
# Cookbook Name:: kafka-cluster
# Recipe:: default
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'libarchive::default'

libarchive_file "apache-kafka-#{node['kafka']['version']}.tar.gz" do
  path node['kafka']['install_path']
  url node['kafka']['url'] % { version: node['kafka']['version'] }
  checksum node['kafka']['checksum']
end

poise_service_user node['kafka']['user']
poise_service node['kafka']['service_name'] do

end
