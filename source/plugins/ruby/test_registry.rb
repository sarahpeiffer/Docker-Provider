# require_relative 'KubernetesApiClient'
require_relative 'ApplicationInsightsUtility'


class Test_registry
    include Singleton

    attr_reader :applicationInsightsUtility, :env, :kubernetesApiClient
    attr_writer :applicationInsightsUtility, :env, :kubernetesApiClient

    def initialize
        @applicationInsightsUtility = ApplicationInsightsUtility
        @env = ENV
        @kubernetesApiClient = KubernetesApiClient
    end
end
