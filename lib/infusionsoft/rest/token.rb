require 'rest-client'
require 'uri'
require 'json'

module Infusionsoft
  module Rest

    class Token
      attr_accessor :access_token, :refresh_token, :expiration

      def initialize(token_params)
        @access_token = token_params[:access_token] || token_params["access_token"]
        @refresh_token = token_params[:refresh_token] || token_params["refresh_token"]
        @expiration = token_params[:expiration] if token_params[:expiration]

        if token_params[:expires_in] || token_params["expires_in"]
          @expiration = Time.now + (token_params[:expires_in] || token_params["expires_in"])
        end
      end

      def valid?
        Time.now < expiration
      end

      class << self
        def auth_url(client_id, redirect_uri)
          params = {
            client_id: client_id,
            redirect_uri: redirect_uri,
            scope: 'full',
            response_type: 'code'
          }

          uri = URI::HTTPS.build({host: "signin.infusionsoft.com", path: "/app/oauth/authorize", query: URI.encode_www_form(params)})
          uri.to_s
        end

        def refresh(client_id, client_secret, refresh_token)
          params = {
            grant_type: 'refresh_token',
            refresh_token: refresh_token,
          }

          header = { "Authorization": "Basic " + Base64.urlsafe_encode64("#{client_id}:#{client_secret}")}

          response = RestClient.post("https://api.infusionsoft.com/token", params, header)

        rescue RestClient::ExceptionWithRespone => e
          #TODO what to do here?
          false
        else
          token_params = JSON.parse(response.body)
          self.new(token_params)
        end

        def get_token(client_id, client_secret, redirect_uri, code)
          params = {
            client_id: client_id,
            client_secret: client_secret,
            redirect_uri: redirect_uri,
            code: code,
            grant_type: 'authorization_code',
          }

          response = RestClient.post("https://api.infusionsoft.com/token", params)
        rescue RestClient::ExceptionWithResponse => e
          # TODO: what to do here
          false
        else
          token_params = JSON.parse(response.body)
          self.new(token_params)
        end
      end
    end

  end
end