describe service('zookeeper') do
  it { should be_enabled }
  it { should be_running }
end

describe service('kafka') do
  it { should be_enabled }
  it { should be_running }
end
