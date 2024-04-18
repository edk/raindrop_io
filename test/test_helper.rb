# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "raindrop_io"
require "minitest/autorun"
require "vcr"
require "minitest/reporters"
Minitest::Reporters.use!

if ENV["RAINDROP_TOKEN"].nil?
  puts "WARNING: RAINDROP_TOKEN is not set. Please set it in your environment variables."
end

VCR.configure do |config|
  config.cassette_library_dir = "test/fixtures/vcr_cassettes"
  config.hook_into :webmock

  config.filter_sensitive_data("<BEARER_TOKEN>") do
    ENV["RAINDROP_TOKEN"]
  end
end
