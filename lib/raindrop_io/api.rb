require "httparty"
require "erb"

module RaindropIo
  class ApiError
    attr_reader :status, :message
    attr_reader :response # to view the raw response for debugging

    def initialize(response)
      @status = response.code
      @message = response.message
      @response = response
    end
  end

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
        HTTParty.get(build_url(path), options)
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
    end
  end
end
