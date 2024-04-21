# frozen_string_literal: true

require "test_helper"

class TestRaindropIoRaindrop < Minitest::Test
  def setup
    RaindropIo::Api.configure do |config|
      config.api_token = ENV["RAINDROP_TOKEN"]
    end
  end

  def test_get_raindrops_from_collection
    VCR.use_cassette("raindrops_multiple_from_collection") do
      RaindropIo::Raindrop.raindrops("-1")
      # binding.pry
      # assert_instance_of Array, response
      # assert_instance_of RaindropIo::Raindrop, response.first
    end
  end

  def test_raindrops_pagination
  end

  # def test_single_raindrop
  #   VCR.use_cassette('single_raindrop') do
  #     response = api.raindrop("768481303")
  #     refute_nil response
  #   end
  # end
end
