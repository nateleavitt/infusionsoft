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
        @retry_count += 1
        puts "*** INFUSION API TIMEOUT: retrying #{@retry_count} ***"
        retry if ok_to_retry
      rescue XMLRPC::FaultException => e
        puts "*** INFUSION API ERROR: #{e.faultCode} - #{e.faultString} ***"
      end

      return result
    end

    def ok_to_retry
      @retry_count <= 5 ? true : false
    end

  end
end
