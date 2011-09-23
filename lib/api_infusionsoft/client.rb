module ApiInfusionsoft
  # Wrapper for the Infusionsoft API
  #
  # @note all services have been separated into different modules

  class Client < Api
    # Require client method modules after initializing the Client class in
    # order to avoid a superclass mismatch error, allowing those modules to be
    # Client-namespaced.
    require 'api_infusiosnoft/client/contact'
    require 'api_infusiosnoft/client/email'
    require 'api_infusiosnoft/client/invoice'
    require 'api_infusiosnoft/client/data'
    require 'api_infusiosnoft/client/affiliate'
    require 'api_infusiosnoft/client/file'
    require 'api_infusiosnoft/client/ticket'

    include ApiInfusionosft::Client::Contact
    include ApiInfusionosft::Client::Email
    include ApiInfusionosft::Client::Invoice
    include ApiInfusionosft::Client::Data
    include ApiInfusionosft::Client::Affiliate
    include ApiInfusionosft::Client::File
    include ApiInfusionosft::Client::Ticket
  end
end
