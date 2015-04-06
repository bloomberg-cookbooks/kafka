#
# Cookbook Name:: kafka-cluster
# Recipe:: default
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
# All rights reserved - Do Not Redistribute
#
default['kafka']['version'] = ''
default['kafka']['url'] = ''
default['kafka']['checksum'] = ''
default['kafka']['install_path'] = '/opt/kafka'

default['kafka']['service_name'] = 'kafka'
default['kafka']['username'] = 'kafka'
