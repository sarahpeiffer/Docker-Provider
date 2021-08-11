#!/usr/local/bin/ruby
# frozen_string_literal: true

require_relative "test_registry"

class CustomMetricsUtils
    def initialize
    end

    class << self
        def check_custom_metrics_availability
            aks_region = Test_registry.instance.env['AKS_REGION']
            aks_resource_id = Test_registry.instance.env['AKS_RESOURCE_ID']
            aks_cloud_environment = Test_registry.instance.env['CLOUD_ENVIRONMENT']
            if aks_region.to_s.empty? || aks_resource_id.to_s.empty?
                return false # This will also take care of AKS-Engine Scenario. AKS_REGION/AKS_RESOURCE_ID is not set for AKS-Engine. Only ACS_RESOURCE_NAME is set
            end

            return aks_cloud_environment.to_s.downcase == 'azurepubliccloud'
        end
    end
end