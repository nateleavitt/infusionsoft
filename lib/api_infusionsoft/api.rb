require 'api_infusionsoft/configuration'
require 'api_infusionosft/connection'
require 'api_infusionsoft/request'

module ApiInfusionsoft

  class Api
    include Connection
    include Request

    attr_accessor *Configuration::VALID_OPTION_KEYS

    def initialize(options={})
      options = ApiInfusionsoft.options.merge(options)
      Configuration::VALID_OPTION_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

  end

end
