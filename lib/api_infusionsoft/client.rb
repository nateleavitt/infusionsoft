module ApiInfusionsoft
  # Wrapper for the Infusionsoft API
  #
  # @note all services have been separated into different modules

  class Client < Api
    # Require client method modules after initializing the Client class in
    # order to avoid a superclass mismatch error, allowing those modules to be
    # Client-namespaced.
    require 'api_infusionsoft/client/contact'
    require 'api_infusionsoft/client/email'
    require 'api_infusionsoft/client/invoice'
    require 'api_infusionsoft/client/data'
    require 'api_infusionsoft/client/affiliate'
    require 'api_infusionsoft/client/file'
    require 'api_infusionsoft/client/ticket'

    include ApiInfusionsoft::Client::Contact
    include ApiInfusionsoft::Client::Email
    include ApiInfusionsoft::Client::Invoice
    include ApiInfusionsoft::Client::Data
    include ApiInfusionsoft::Client::Affiliate
    include ApiInfusionsoft::Client::File
    include ApiInfusionsoft::Client::Ticket
  end
end
