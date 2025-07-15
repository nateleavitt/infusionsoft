require "xmlrpc/client"
require 'infusionsoft/exception_handler'

module Infusionsoft
  module Connection
    private

    def connection(service_call, *args)
      client = XMLRPC::Client.new3({
        'host' => api_url,
        'path' => '/crm/xmlrpc/v1',
        'port' => 443,
        'use_ssl' => true
      })
      client.http_header_extra = define_headers

      begin
        # Fill the api_key param and doesn't send real api_key if is present - Avoid error https://github.com/nateleavitt/infusionsoft/pull/85#issuecomment-2404189445
        args.insert(0, '')
        api_logger.info "CALL: #{service_call} api_url: #{api_url} at:#{Time.now} args:#{args.inspect}"
        result = client.call("#{service_call}", *args)
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

    def define_headers
      headers = { 'User-Agent' => user_agent }
    
      if use_oauth
        headers['Authorization'] = "Bearer #{api_key}"
      elsif sak_key
        headers['Authorization'] = "Bearer #{sak_key}"
      else
        headers['X-Keap-API-Key'] = api_key
      end

      headers
    end
  end
end
