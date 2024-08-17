require 'infusionsoft/api'
require 'infusionsoft/client'
require 'infusionsoft/configuration'
require 'infusionsoft/api_logger'
require 'infusionsoft/rest/token'

module Infusionsoft
  extend Configuration
  class << self
    # Alias for Infusionsoft::Client.new
    #
    # @return [Infusionsoft::Client]
    def new(options={})
      Infusionsoft::Client.new(options)
    end

    # Delegate to ApiInfusionsoft::Client
    def method_missing(method, *args, **kwargs, &block)
      return super unless new.respond_to?(method)
      new.send(method, *args, **kwargs, &block)
    end

    def respond_to?(method, include_private = false)
      new.respond_to?(method, include_private) || super(method, include_private)
    end
  end
end

