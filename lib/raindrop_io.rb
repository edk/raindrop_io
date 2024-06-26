# frozen_string_literal: true

require_relative "raindrop_io/version"
require_relative "raindrop_io/api"
require_relative "raindrop_io/base"
require_relative "raindrop_io/user"
require_relative "raindrop_io/raindrop"
require_relative "raindrop_io/collection"
require "logger"

begin
  require "pry"
  require "byebug"
rescue LoadError
end

module RaindropIo
  class Error < StandardError; end
end
