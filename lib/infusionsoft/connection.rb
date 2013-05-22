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
      
      #If the cert_file configuration option exists,
      #set the http verify mode and ca_file variables to reflect local ssl certificate path.
      unless cert_file.nil?
        server.instance_variable_get("@http".verify_mode = OpenSSL::SSL::VERIFY_PEER
        server.instance_variable_get("@http").ca_file = cert_file
      end
      
      begin
        result = server.call("#{service_call}", api_key, *args)
        if result.nil?; result = [] end
      rescue Timeout::Error => timeout
        # Retry up to 5 times on a Timeout before raising it
        ok_to_retry(timeout) ? retry : raise
      rescue => e
        # Wrap the underlying error in an InfusionAPIError
        raise InfusionAPIError.new(e.to_s, e)
      end

      return result
    end

    def ok_to_retry(e)
      @retry_count += 1
      if @retry_count <= 5
        Rails.logger.info "!!! INFUSION API ERROR: [#{e}] retrying #{@retry_count}" if Rails
        true
      else
        false
      end
    end

  end
end

# Extend StandardError to keep track of Error being wrapped
# Pattern from Exceptional Ruby by Avdi Grimm (http://avdi.org/talks/exceptional-ruby-2011-02-04/)
class InfusionAPIError < StandardError
  attr_reader :original
    def initialize(msg, original=nil);
      super(msg);
      @original = original;
    end
end
