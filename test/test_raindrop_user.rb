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
      assert user._id.to_s == "123456789", "Expected 123456789, got #{user._id}"

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
      assert user.name == "user123", "Expected user123, got #{user.name}"
      assert user.email == "user123@example.com", "Expected email: user123@example.com, got #{user.email}"
      assert user._id.to_s == "123456789", "Expected 123456789, got #{user._id}"
      assert user.groups.size == 1, "Expected 1 group, got #{user.groups.size}"
      assert user.groups[0]["collections"] == [43358979, 43330903, 36370053, 43358978], "Expected collections, got #{user.groups[0]["collections"]}"
      collections = user.collections
      assert collections.size == 4, "Expected 4 collections, got #{collections.size}"
      assert_equal collections[0]._id, "123456789"
      assert_equal collections[1].title, "tech"
    end
  end

  def test_finding_user_by_name
    # skip "Can't get the api endpoint to work"
    # VCR.use_cassette("find_user_by_name") do
    #   user = RaindropIo::User.find_by_name("somename")
    #   refute_nil user.is_a?(RaindropIo::ApiError)
    # end
  end
end
