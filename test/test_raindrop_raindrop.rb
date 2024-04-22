# frozen_string_literal: true

require "test_helper"

class TestRaindropIoRaindrop < Minitest::Test
  def setup
    RaindropIo::Api.configure do |config|
      config.api_token = ENV["RAINDROP_TOKEN"]
    end
  end

  def test_get_raindrops_from_unread_collection
    VCR.use_cassette("raindrops_from_unread") do
      assert_equal RaindropIo::Raindrop.default_page_size, 25

      raindrops = RaindropIo::Raindrop.raindrops("36370053", page: 0)
      assert_equal raindrops[:total], 706
      assert_instance_of Array, raindrops[:items]
      assert_equal raindrops[:items].size, 25

      number_of_pages = (raindrops[:total] / RaindropIo::Raindrop.default_page_size)
      raindrops2 = RaindropIo::Raindrop.raindrops("36370053", page: number_of_pages)
      assert_instance_of Array, raindrops2[:items]
      assert_equal raindrops2[:items].size, 6
    end
  end

  def test_get_raindrops_from_collection
    VCR.use_cassette("raindrops_multiple_from_collection") do
      drops = RaindropIo::Raindrop.raindrops("-1")
      assert_instance_of Array, drops[:items]
      assert_instance_of RaindropIo::Raindrop, drops[:items].first
      assert_equal drops[:items].size, 25
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
