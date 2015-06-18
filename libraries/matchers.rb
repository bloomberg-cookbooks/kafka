if defined?(ChefSpec)
  %i{enable disable start stop restart}.each do |action|
    define_method(:"#{action}_kafka_service") do |resource_name|
      ChefSpec::Matchers::ResourceMatcher.new(:kafka_service, action, resource_name)
    end
  end

  def create_kafka_config(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:kafka_config, :create, resource_name)
  end

  def delete_kafka_config(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:kafka_config, :delete, resource_name)
  end
end
