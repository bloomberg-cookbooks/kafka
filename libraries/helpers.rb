#
# Cookbook: kafka-cluster-cookbook
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
module KafkaCluster
  def service_name
    node['kafka-cluster']['service_name']
  end

  def service_init_type
    node['kafka-cluster']['service_init_type']
  end

  def config_filepath(cluster_name)
    File.join(config_directory, "#{cluster_name}.cfg")
  end

  def config_directory
    File.join(ArtifactCookbook.shared_path(service_name), 'conf')
  end

  def run_user
    node['kafka-cluster']['username']
  end

  def run_group
    node['kafka-cluster']['groupname']
  end

  def run_environment
    {
     'JAVA_HOME' => node['java']['java_home']
    }.merge(node['kafka-cluster']['environment'])
  end
end
