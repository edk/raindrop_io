#!/usr/bin/env ruby
require "json"
require "yaml"
require "pry"

def sanitize_data(data, replacements)
  data.each do |key, value|
    puts "key: #{key}, value: #{value}"
    if value.is_a?(Hash) || value.is_a?(Array)
      sanitize_data(value, replacements)
    elsif replacements.key?(key)
      puts "replacing #{key} with #{replacements[key]}..."
      data[key] = replacements[key]
    end
  end
end

def sanitize_response(file_path)
  data = YAML.unsafe_load_file(file_path)
  puts "Sanitizing #{file_path}..."

  replacements_path = File.join(File.dirname(file_path), "replace_sensitive_info.json")
  replacements = JSON.parse(File.read(replacements_path))
  puts "Using replacements from #{replacements_path}\nreplacements: #{replacements}"

  data["http_interactions"].each do |interaction|
    response_body = JSON.parse(interaction["response"]["body"]["string"])
    puts "sanitizing response body..."
    sanitize_data(response_body, replacements)
    interaction["response"]["body"]["string"] = response_body.to_json
  end

  File.open(file_path, "w") { |file| file.puts data.to_yaml }
end

if ARGV.size == 0
  puts "Usage: #{$PROGRAM_NAME} [file_path]..."
  puts "Ensure you create a json file called 'replace_sensitive_info' with key/value pairs to replace sensitive info in the response body."
  puts "e.g. {\"email\": \"fakeEmail@example.com\"}"
  exit 1
end

ARGV.each do |file_path|
  sanitize_response(file_path)
end
