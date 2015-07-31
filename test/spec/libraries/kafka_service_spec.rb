require 'poise_boiler/spec_helper'
require_relative '../../../libraries/kafka_service'

describe KafkaClusterCookbook::Resource::KafkaService do
  step_into(:kafka_service)
end
