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
        chlogger.info "INFUSION API call:#{service_call} api_key: #{api_key} args: #{*args} at: #{Time.now}"
        result = server.call("#{service_call}", api_key, *args)
        if result.nil?; ok_to_retry('nil response') end
      rescue XMLRPC::Client::InfusionAPINilContentTypeError => nil_content
        # Retry up to 5 times on a nil content-type response from Infusionsoft
        ok_to_retry(nil_content) ? retry : raise
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
        chlogger.warn "!!! INFUSION API ERROR: [#{e}] retrying #{@retry_count}" if Rails
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
