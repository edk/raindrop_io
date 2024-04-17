# frozen_string_literal: true

require "test_helper"

class TestRaindropIoCollection < Minitest::Test
  def setup
    RaindropIo::Api.configure do |config|
      config.api_token = ENV["RAINDROP_TOKEN"]
    end
  end

  def test_collections
    VCR.use_cassette("collections") do
      response = RaindropIo::Collection.all
      assert response.size == 2, "Expected 2 collections, got #{response.size}\n#{response.inspect}"
      refute_nil response
    end
  end
end
