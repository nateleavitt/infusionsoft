require "xmlrpc/client"
require 'infusionsoft/exception_handler'

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
        api_logger.info "CALL: #{service_call} api_key:#{api_key} at:#{Time.now} args:#{args.inspect}"
        result = server.call("#{service_call}", api_key, *args)
        if result.nil?; ok_to_retry('nil response') end
      rescue XMLRPC::Client::InfusionAPINilContentTypeError => nil_content
      # Retry up to 5 times on a nil content-type response from Infusionsoft
      ok_to_retry(nil_content) ? retry : raise
      rescue Timeout::Error => timeout
        # Retry up to 5 times on a Timeout before raising it
        ok_to_retry(timeout) ? retry : raise
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
