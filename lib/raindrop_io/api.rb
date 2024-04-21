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

      def initialize
        @base_uri = "https://api.raindrop.io/rest/v1"
        @api_token = nil
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
        options[:headers] = headers
        HTTP.headers(options).get(build_url(path))
      end

      private

      def build_url(path)
        File.join [configuration.base_uri, path]
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
