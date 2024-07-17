require 'rest-client'

module Infusionsoft
  # Incase Infusionsoft ever creates a restful API :)
  module Request
    def xmlrpc(service_call, *args)
      connection(service_call, *args)
    end

    # Perform an GET request
    def get(path, token, query: {}, version: 'v1')
      request(:get, path, token, query, version)
    end

    def post(path, token, query: {}, payload: {}, version: 'v1')
      request(:post, path, token, query, payload, version)
    end

    # Perform an HTTP PUT request
    def put(path, token, query: {}, payload: {}, version: 'v1')
      request(:put, path, token, query, payload, version)
    end

    # Perform an HTTP PATCH request
    def patch(path, token, query: {}, payload: {}, version: 'v1')
      request(:patch, path, token, query, payload, version)
    end

    # Perform an HTTP DELETE request
    def delete(path, token, query: {}, version: 'v1')
      request(:delete, path, token, query, version)
    end

    private

    # Perform request
    def request(method, path, token, query={}, payload={}, version)
      path = "/#{path}" unless path.start_with?('/')
      header = {
        authorization: "Bearer #{token.access_token}",
        content_type: :json,
        accept: :json,
        params: query
      }
      opts = {
        method: method,
        url: "https://api-intg.infusiontest.com/crm/rest/v1" + path,
        headers: header
      }
      # Use v2 if specified
      if version == 'v2'
        opts[:url] = "https://api-intg.infusiontest.com/crm/rest/v2" + path
      end

      opts.merge!( { payload: payload.to_json }) unless payload.empty?
      resp = RestClient::Request.execute(opts)
      return JSON.parse(resp.body) if resp.body # Some calls respond w nothing
    rescue RestClient::ExceptionWithResponse => err
      api_logger.error "[ERROR]: #{err}"
    rescue => err
      # RestClient::Unauthorized & SocketError
      api_logger.error "[ERROR]: #{err}"
      raise
    end
  end
end
