module Infusionsoft
  # Wrapper for the Infusionsoft API
  #
  # @note all services have been separated into different modules
  class Client < Api
    # Require client method modules after initializing the Client class in
    # order to avoid a superclass mismatch error, allowing those modules to be
    # Client-namespaced.
    require 'infusionsoft/client/contact'
    require 'infusionsoft/client/email'
    require 'infusionsoft/client/invoice'
    require 'infusionsoft/client/data'
    require 'infusionsoft/client/affiliate'
    require 'infusionsoft/client/file'
    require 'infusionsoft/client/ticket' # Deprecated by Infusionsoft
    require 'infusionsoft/client/search'
    require 'infusionsoft/client/credit_card'
    require 'infusionsoft/client/funnel'

    include Infusionsoft::Client::Contact
    include Infusionsoft::Client::Email
    include Infusionsoft::Client::Invoice
    include Infusionsoft::Client::Data
    include Infusionsoft::Client::Affiliate
    include Infusionsoft::Client::File
    include Infusionsoft::Client::Ticket # Deprecated by Infusionsoft
    include Infusionsoft::Client::Search
    include Infusionsoft::Client::CreditCard
    include Infusionsoft::Client::Funnel
  end
end
