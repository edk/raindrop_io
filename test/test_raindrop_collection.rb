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
      collection = RaindropIo::Collection.all
      refute collection.is_a?(RaindropIo::ApiError)
      assert_equal collection.size, 3
      assert_equal collection[0].title, "Unread"
      assert_equal collection[1].title, "tech"
    end
  end

  def test_collection_children
    VCR.use_cassette("collection_children") do
      collections = RaindropIo::Collection.childrens
      refute collections.is_a?(RaindropIo::ApiError)
      assert_equal collections.map(&:title), ["programming", "AI/ML", "DevOps", "hardware", "networking"]
    end
  end

  def test_get_single_collection
    VCR.use_cassette("single_collection") do
      collection = RaindropIo::Collection.find(43330952)
      refute collection.is_a?(RaindropIo::ApiError)
      assert_equal collection.title, "hardware"
    end
  end

  def test_collection_stats
    VCR.use_cassette("collection_stats") do
      result = RaindropIo::Collection.stats
      assert_equal result["items"][0]["count"], 1450
      assert_equal result["meta"]["pro"], false
    end
  end
end
