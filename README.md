# RaindropIo

A simple Ruby gem to access the Raindrop.io API.

Note that this was created for my own personal project, and thus, nowhere
near complete.  However, I welcome any contributions to improve the converage.
Ensure that any VCR cassettes are sanitized of any sensitive information before
making a PR.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add raindrop_io

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install raindrop_io

## Usage

Set the API token with:
```
RaindropIo::Api.configure { |c| c.api_token = ENV["RAINDROP_TOKEN"] }
```
Any further operations with the classes:
* RaindropIo::Collection
* RaindropIo::Raindrop 
* RaindropIo::User 

will use that token.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

You can set the token like so:
```
RAINDROP_TOKEN="11111111-2222-3333-4444-555555555555" bin/console
RAINDROP_TOKEN="11111111-2222-3333-4444-555555555555" bundle exec rake test
```
etc.

Note that since this was intended for my own personal use, I did not bother
to implement OAuth authentication, only bearer token usage.  Feel free to
make a tested, documented PR.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/edk/raindrop_io.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
