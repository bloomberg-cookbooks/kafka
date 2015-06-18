source 'https://supermarket.chef.io'
cookbook 'zookeeper-cluster', git: 'https://bbgithub.dev.bloomberg.com/chef-cookbooks/zookeeper-cluster'
metadata

group :test, :development do
  cookbook 'test-cluster', path: File.expand_path('../test/fixtures/test-cluster', __FILE__)
end
