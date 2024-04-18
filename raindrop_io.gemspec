# frozen_string_literal: true

require_relative "lib/raindrop_io/version"

Gem::Specification.new do |spec|
  spec.name = "raindrop_io"
  spec.version = RaindropIo::VERSION
  spec.authors = ["EDK"]
  spec.email = ["54091+edk@users.noreply.github.com"]

  spec.summary = "Ruby api wrapper to access raindrop.io"
  spec.description = "Ruby api wrapper to access raindrop.io"
  spec.homepage = "https://github.com/edk/raindrop_io"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["documentation_uri"] = "https://edk.github.io/raindrop_io/"
  spec.metadata["source_code_uri"] = "https://github.com/edk/raindrop_io"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "httparty"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"

  spec.add_development_dependency "pry"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
