require 'infusionsoft/configuration'
require 'infusionsoft/connection'
require 'infusionsoft/request'

module Infusionsoft

  class Api
    include Connection
    include Request

    attr_accessor :retry_count
    attr_accessor *Configuration::VALID_OPTION_KEYS

    def initialize(options={})
      @retry_count = 0
      options = Infusionsoft.options.merge(options)
      Configuration::VALID_OPTION_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

  end

end
