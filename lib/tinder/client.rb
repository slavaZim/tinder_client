# frozen_string_literal: true

require "tinder_client"
require "faraday"

module Tinder

  class Client
    # Always prefer V2 endpoints as the API is less buggy than V1
    BASE_URI  = 'https://api.gotinder.com'
    ENDPOINTS = {
      request_code:    "/v2/auth/sms/send?auth_type=sms",
      login:           "/v2/auth/login/sms",
      validate:        "/v2/auth/sms/validate?auth_type=sms",
      recommendations: "/v2/recs/core",
      updates:         "/updates"
    }

    ENDPOINTS_V3 = {
        login:           "/v3/auth/login?locale=ru",
        validate:        "/v3/auth/sms/validate?auth_type=sms",
    }

    attr_accessor :api_token
    attr_accessor :refresh_token

    def post(url, version = :v2, **data)
      case version
      when :v2
        response = Faraday.post(url, JSON.generate(data), headers(version))
        JSON.parse(response.body) unless response.body.nil?
      when :v3
        response = Faraday.post(url, data[:payload].to_proto, headers(version))
        puts response.body.inspect
      end
    end

    def get(url, **data)
      # GET requests won't get a response using JSON
      response = Faraday.get(url, data, headers)
      JSON.parse(response.body) unless response.body.nil?
    end

    # @param phone_number String
    def request_code(phone_number)
      phone = Tinder::Services::Authgateway::Phone.new(phone: phone_number)
      payload =  Tinder::Services::Authgateway::AuthGatewayRequest.new(phone: phone)
      response = post(endpoint(:login, :v3), :v3, payload: payload)
      puts response.inspect
      response.dig('data', 'sms_sent') || fail(UnexpectedResponse.new(response))
    end

    # @param phone_number String Your phone number
    # @param confirmation_code String The code sent to your phone
    # @return String Named 'refresh token', this is one part of the 2-part authentication keys
    def validate(phone_number, confirmation_code)
      data = { otp_code:     confirmation_code,
               phone_number: phone_number,
               is_update:    false }

      response       = post(endpoint(:validate), data)
      @refresh_token = response.dig('data', 'refresh_token') || fail(UnexpectedResponse.new(response))
    end

    # @param phone_number String Your phone number
    # @param confirmation_code String The code sent to your phone
    # @return String The API key
    def login(phone_number, refresh_token)
      data     = { refresh_token: refresh_token, phone_number: phone_number }
      response = post(endpoint(:login),  data)

      @api_token   = response.dig('data', 'api_token') || fail(UnexpectedResponse.new(response))
      @id          = response['data']['_id']
      @is_new_user = response['data']['is_new_user']
      @api_token
    end

    def endpoint(action, version = :v2)
      case version
      when :v2
        "#{BASE_URI}#{ENDPOINTS[action]}"
      when :v3
        "#{BASE_URI}#{ENDPOINTS_V3[action]}"
      end
    end

    protected

    def headers(endpoint = :v2)
      {
        "app_version":  "6.9.4",
        "platform":     "ios",
        "content-type": endpoint == :v2 ? "application/json" : 'application/x-google-protobuf',
        "User-agent":   "Tinder/7.5.3 (iPhone; iOS 10.3.2; Scale/2.00)",
        "Accept":       "application/json",
        "X-Auth-Token": api_token
      }
    end

  end
end
