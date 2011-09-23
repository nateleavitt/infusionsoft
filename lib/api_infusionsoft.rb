require 'api_infusionsoft/api'
require 'api_infusionsoft/client'
require 'api_infusionsoft/configuration'
#require 'api_infusionsoft/base'
#require 'api_infusionsoft/error'
#require 'api_infusionsoft/search'

module ApiInfusionsoft
  extend Configuration
  class << self
    # Alias for ApiInfusionsoft::Client.new
    #
    # @return [ApiInfusionsoft::Client]
    def new(options={})
      ApiInfusionsoft::Client.new(options)
    end

    # Delegate to ApiInfusionsoft::Client
    def method_missing(method, *args, &block)
      return super unless new.respond_to?(method)
      new.send(method, *args, &block)
    end

    def respond_to?(method, include_private = false)
      new.respond_to?(method, include_private) || super(method, include_private)
    end
  end
end

