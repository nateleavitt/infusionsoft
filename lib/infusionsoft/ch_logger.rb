require "xmlrpc/client"

module Infusionsoft
  module CHLogger
    def chlogger
      @@chlogger ||= Logger.new("#{Rails.root}/log/infusionsoft_api.log")
    end
  end
end
