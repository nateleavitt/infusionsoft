require 'rest-client'

module Infusionsoft
  # Incase Infusionsoft ever creates a restful API :)
  module Request
    def xmlrpc(service_call, *args)
      connection(service_call, *args)
    end

    # Perform an GET request
    def get(path, token, query: {})
      request(:get, path, token, query: query )
    end

    def post(path, token, query: {}, payload: {})
      request(:post, path, token, query, payload)
    end

    # Perform an HTTP PUT request
    def put(path, token, query: {}, payload: {})
      request(:put, path, token, query, payload)
    end

    # Perform an HTTP DELETE request
    def delete(path, token, query: {})
      request(:delete, path, token, query)
    end

    private

    # Perform request
    def request(method, path, token, query={}, payload={})
      path = "/#{path}" unless path.start_with?('/')
      header = {
        authorization: "Bearer #{token.access_token}",
        content_type: :json,
        accept: :json,
        params: query
      }
      opts = {
        method: method,
        url: "https://api.infusionsoft.com/crm/rest/v1" + path,
        headers: header
      }
      opts.merge!( { payload: payload.to_json }) unless payload.empty?
      resp = RestClient::Request.execute(opts)
    rescue RestClient::ExceptionWithResponse => err
      # log error?
    else
      return JSON.parse(resp.body)
    end
  end
end
