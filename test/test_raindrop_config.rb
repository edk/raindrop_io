# frozen_string_literal: true

require "test_helper"

class TestRaindropIoConfig < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::RaindropIo::VERSION
  end

  def test_configuration
    RaindropIo::Api.configure do |config|
      config.api_token = "1234567890"
    end
    assert RaindropIo::Api.configuration.api_token == "1234567890"
  end

  def test_ensure_token_in_header
    RaindropIo::Api.configure do |config|
      config.api_token = "1234567890"
    end
    assert_equal RaindropIo::Api.send(:headers)["Authorization"], "Bearer 1234567890"
  end
end
