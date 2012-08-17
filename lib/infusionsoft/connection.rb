require "xmlrpc/client"

module Infusionsoft
  module Connection
    private

    def connection(service_call, *args)
      server = XMLRPC::Client.new3({
        'host' => api_url,
        'path' => "/api/xmlrpc",
        'port' => 443,
        'use_ssl' => true
      })
      begin
        result = server.call("#{service_call}", api_key, *args)
        if result.nil?; result = [] end
      rescue Timeout::Error
        retry if ok_to_retry
      rescue
        retry if ok_to_retry
      end

      return result
    end

    def ok_to_retry
      @retry_count += 1
      if @retry_count <= 5
        Rails.logger.info "*** INFUSION API ERROR: retrying #{@retry_count} ***" if Rails
        true
      else
        false
      end
    end

  end
end

class InfusionAPIError < StandardError; end
