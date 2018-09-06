name 'default'
default_source :community
default_source :chef_repo, 'test/fixtures'
cookbook 'kafka-cluster', path: '.'
run_list 'kafka-cluster::default', 'test-cluster::default'
named_run_list :centos, 'sudo::default', 'yum::default', 'yum-epel::default', run_list
named_run_list :debian, 'sudo::default', 'apt::default', run_list

default['authorization']['sudo']['passwordless'] = true
default['authorization']['sudo']['users'] = %w(vagrant kitchen)
