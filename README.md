# ActiveError
Short description and motivation.

## Installation
Add this line to your application's Gemfile:

```ruby
gem "activeerror"
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install activeerror
```

And then install migrations:
```bash
bin/rails active_error:install
bin/rails rails db:migrate
```

This also mounts a route n your routes file to view the errors.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rails test` to run the unit tests.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, execute `bin/publish (major|minor|patch)` which will
update the version number in `version.rb`, create a git tag for the version,
push git commits and tags, and push the `.gem` file to GitHub.

## Contributing

Bug reports and pull requests are welcome on
[GitHub](https://github.com/npezza93/active_error). This project is intended to
be a safe, welcoming space for collaboration, and contributors are expected to
adhere to the [Contributor Covenant](http://contributor-covenant.org) code of
conduct.

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).
