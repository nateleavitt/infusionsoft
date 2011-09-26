module Infusionsoft

  module Configuration
    VALID_OPTION_KEYS = [
      :api_url,
      :api_key
    ].freeze

    # @private
    attr_accessor *VALID_OPTION_KEYS

    # When this module is extended, set all configuration options to their default values
    #def self.extended(base)
      #base.reset
    #end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end

    # Create a hash of options and their values
    def options
      options = {}
      VALID_OPTION_KEYS.each{|k| options[k] = send(k)}
      options
    end

    #def reset
      #self.url = ''
      #self.api_key = 'na'
    #end

  end

end
