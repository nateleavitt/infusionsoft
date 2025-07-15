require 'rest-client'
require 'json'

module Infusionsoft
  # Incase Infusionsoft ever creates a restful API :)
  module Request
    def xmlrpc(service_call, *args)
      connection(service_call, *args)
    end

    # Perform an GET request
    def get(path, token, query: {}, version: 'v1')
      request(:get, path, token, version, query: query)
    end

    def post(path, token, query: {}, payload: {}, version: 'v1')
      request(:post, path, token, version, query, payload)
    end

    # Perform an HTTP PUT request
    def put(path, token, query: {}, payload: {}, version: 'v1')
      request(:put, path, token, version, query, payload)
    end

    # Perform an HTTP PATCH request
    def patch(path, token, query: {}, payload: {}, version: 'v1')
      request(:patch, path, token, version, query, payload)
    end

    # Perform an HTTP DELETE request
    def delete(path, token, query: {}, payload: {}, version: 'v1')
      request(:delete, path, token, version, query, payload)
    end

    private

    # Perform request
    def request(method, path, token, version, query={}, payload={})
      path = "/#{path}" unless path.start_with?('/')
      header = {
        authorization: "Bearer #{token.access_token}",
        content_type: :json,
        accept: :json,
        params: query
      }

      opts = {
        method: method,
        url: "https://api.infusionsoft.com/crm/rest/#{version}" + path,
        headers: header
      }
      opts.merge!( { payload: payload.to_json }) unless payload.empty?
      resp = RestClient::Request.execute(opts)
      return JSON.parse(resp.body) if resp.body # Some calls respond w nothing
    rescue RestClient::ExceptionWithResponse => err
      api_logger.error "[ERROR]: #{err}"
      handle_rest_error(err)
    rescue => err
      # RestClient::Unauthorized & SocketError
      api_logger.error "[ERROR]: #{err}"
      raise
    end

    # Handle REST API errors by parsing the response and raising appropriate exceptions
    def handle_rest_error(err)
      error_body = err.response.body
      error_data = JSON.parse(error_body) if error_body && !error_body.empty?

      # Extract error details from the response
      status_code = err.response.code
      error_message = error_data&.dig('message') || err.message
      error_code = error_data&.dig('code') || status_code

      # Map HTTP status codes to appropriate exceptions
      exception_class = case status_code
      when 400
        Infusionsoft::InvalidParameterError
      when 401
        Infusionsoft::FailedLoginAttemptError
      when 403
        Infusionsoft::NoAccessError
      when 404
        Infusionsoft::RecordNotFoundError
      when 422
        Infusionsoft::InvalidParameterError
      else
        Infusionsoft::UnexpectedError
      end

      raise exception_class, error_message
    rescue JSON::ParserError
      # If we can't parse the error response, fall back to the original error
      raise Infusionsoft::UnexpectedError, err.message
    end
  end
end
