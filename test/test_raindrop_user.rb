# frozen_string_literal: true

require "test_helper"

class TestRaindropIoRaindrop < Minitest::Test
  def setup
    RaindropIo::Api.configure do |config|
      config.api_token = ENV["RAINDROP_TOKEN"]
    end
  end

  def test_get_current_user
    VCR.use_cassette("current_user") do
      user = RaindropIo::User.current_user
      refute_nil user.is_a?(RaindropIo::ApiError)
      assert user.fullName == "user123"
      assert user.name == "user123"
      assert user.id.to_s == "123456789", "Expected 123456789, got #{user.id}"

      # Per the api docs, nested collections are to be found in the user record under groups
      assert user.groups.size == 1, "Expected 1 group, got #{user.groups.size}"
      assert user.groups[0]["collections"] == [43330903, 36370053], "Expected collections, got #{user.groups[0]["collections"]}"
    end
  end

  def test_current_user_creating_collections
    VCR.use_cassette("current_user_with_collections") do
      user = RaindropIo::User.current_user
      refute_nil user.is_a?(RaindropIo::ApiError)
      assert user.fullName == "user123", "Expected user123, got #{user.fullName}"
      assert user.name == "user123"
      assert user.email == "user123@example.com"
      assert user.id.to_s == "123456789", "Expected 123456789, got #{user.id}"
      assert user.groups.size == 1, "Expected 1 group, got #{user.groups.size}"
      assert user.groups[0]["collections"] == [43358979, 43330903, 36370053, 43358978], "Expected collections, got #{user.groups[0]["collections"]}"
      collections = user.collections
      pp collections
    end
  end
end
