require "xmlrpc/client"
require 'infusionsoft/exception_handler'

module Infusionsoft
  module Connection
    private

    
    def connection(service_call, *args)

      headers = {'User-Agent' => user_agent}

      if api_token
        api_url = 'api.infusionsoft.com'
        path = "/crm/xmlrpc/v1"
        headers["X-Keap-API-Key"] = api_token
      elsif use_oauth
        path = "/crm/xmlrpc/v1?access_token=#{api_key}"
      else
        path = "/api/xmlrpc"
      end
      
      client = XMLRPC::Client.new3({
        'host' => api_url,
        'path' => path,
        'port' => 443,
        'use_ssl' => true
      })
      
      client.http_header_extra = headers
      
      begin
        api_logger.info "CALL: #{service_call} api_url: #{api_url} at:#{Time.now} args:#{args.inspect}"
        result = client.call("#{service_call}", api_key, *args)
        if result.nil?; ok_to_retry('nil response') end
      rescue Timeout::Error => timeout
        # Retry up to 5 times on a Timeout before raising it
        ok_to_retry(timeout) ? retry : raise
      rescue OpenSSL::SSL::SSLError => ssl_error
        # Retry up to 5 times on a SSL Handshake issue w Infusionsoft
        ok_to_retry(ssl_error) ? retry : raise
      rescue XMLRPC::FaultException => xmlrpc_error
        # Catch all XMLRPC exceptions and rethrow specific exceptions for each type of xmlrpc fault code
        Infusionsoft::ExceptionHandler.new(xmlrpc_error)
      end # Purposefully not catching other exceptions so that they can be handled up the stack

      api_logger.info "RESULT: #{result.inspect}"
      return result
    end

    def ok_to_retry(e)
      @retry_count += 1
      if @retry_count <= 5
        api_logger.warn "WARNING: [#{e}] retrying #{@retry_count}"
        true
      else
        false
      end
    end

  end
end
