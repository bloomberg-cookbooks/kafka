#
# Cookbook: kafka-cluster-cookbook
# License: Apache 2.0
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
kafka_cluster_config KafkaCluster::Config.cluster_name do

end

poise_service 'kafka' do
  provider node['kafka-cluster']['init_type']
  user node['kafka-cluster']['username']
  directory ArtifactCookbook.current_symlink(name)
  environment('JAVA_HOME' => node['java']['java_home'])
end
