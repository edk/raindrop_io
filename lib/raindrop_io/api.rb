require "http"
require "erb"

module RaindropIo
  # A wrapper around api errors
  class ApiError
    attr_reader :status, :message
    attr_reader :response # to view the raw response for debugging

    def initialize(response)
      @status = response.code
      if response.content_type.mime_type.nil?
        @message = response.to_s
      elsif response.content_type.mime_type == "application/json"
        @message = if response.status.success?
          response.parse
        else
          response.parse["errorMessage"]
        end
      end
      @response = response
    end
  end

  # Api configuration
  # Usage:
  # RaindropIo::Api.configure do |config|
  #   config.api_token = ENV["RAINDROP_TOKEN"]
  # end
  class Api
    class Configuration
      attr_accessor :api_token
      attr_accessor :base_uri
      attr_accessor :logger

      def initialize
        @base_uri = "https://api.raindrop.io/rest/v1"
        @api_token = nil
        @logger = if defined?(Rails)
          Rails.logger
        else
          Logger.new($stdout) # the default ruby logger
        end
      end
    end

    class << self
      def configuration
        @configuration ||= Configuration.new
      end

      def configure
        yield(configuration)
      end

      def get(path, options = {})
        resp = HTTP.headers(headers).get(build_url(path), params: options)
        log_response_headers(resp)
        resp
      end

      def put(path, options = {})
        resp = HTTP.headers(headers).put(build_url(path), options)
        log_response_headers(resp)
        resp
      end

      def post(path, options = {})
        resp = HTTP.headers(headers).post(build_url(path), options)
        log_response_headers(resp)
        resp
      end

      def delete(path, options = {})
        resp = HTTP.headers(headers).delete(build_url(path), options)
        log_response_headers(resp)
        resp
      end

      def get_config
        configuration
      end

      private

      def build_url(path)
        File.join [configuration.base_uri, path]
      end

      def log_response_headers(response)
        return if configuration.logger.nil?
        # log the the rate limit headers, more later if needed?
        configuration.logger.info "Rate limit: #{response.headers["x-ratelimit-limit"]}," \
        " remaining: #{response.headers["x-ratelimit-remaining"]}," \
        " reset at: #{Time.at(response.headers["x-ratelimit-reset"].to_i)} time to reset: #{response.headers["x-ratelimit-reset"].to_i - Time.now.to_i}"
      end

      def headers
        {"Authorization" => "Bearer #{api_token}", "Content-Type" => "application/json"}
      end

      def api_token
        configuration.api_token
      end
    end # class << self
  end
end
