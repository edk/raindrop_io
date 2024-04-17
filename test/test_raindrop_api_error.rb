# frozen_string_literal: true

require "test_helper"

class TestRaindropIoApiError < Minitest::Test
  def setup
    RaindropIo::Api.configure do |config|
      config.api_token = ENV["RAINDROP_TOKEN"]
    end
  end

  def test_api_error_missing_token
    RaindropIo::Api.configuration.api_token = nil
    VCR.use_cassette("api_error_no_token") do
      result = RaindropIo::Collection.find("1234567890")
      assert result.status == 400
      assert result.message =~ /bad request/i, "response: #{result.response}"
      assert result.is_a?(RaindropIo::ApiError)
    end
  end

  def test_api_error_missing_id
    VCR.use_cassette("api_error") do
      result = RaindropIo::Collection.find("1234567890")
      assert result.is_a?(RaindropIo::ApiError)
      assert result.message =~ /not found/i, "response: #{result.response}"
      assert result.status == 404
    end
  end
end
