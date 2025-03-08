# ActiveError

One of the fundemental tools needed to take your Rails app to production is a
way to track errors that are triggered. Unfortunately, there aren't many free,
easy, open source ways to track them for small or medium apps. Honeybadger, Sentry,
and AppSignal are great, but they are are closed source. With Sentry
looking at using your data as training
data([link](https://blog.sentry.io/ai-privacy-and-terms-of-service-updates/?original_referrer=https%3A%2F%2Fsentry.io%2F))
there should be an easy open source alternative where you control the data.
With Rails 8's ethos of No PAAS, there should be a way for new apps to start out
with a basic error reporter and not be forced to pay a third party for one.

ActiveError hooks into the [error reporting
api](https://guides.rubyonrails.org/error_reporting.html) baked directly into
Rails. These third party error loggers also try to make their own fancy
backtrace and debugging view. But the one Rails developers are most comfortable
with is the one baked into Rails that we use everyday in development. So with
ActiveError, when an error gets raised it's captured and stored in the
database (we attempt to group the same error together as Instances to reduce
noise) and then we recreate the error and display it using the built in debug
view from Rails (with a few font and styling tweaks). Once you've resolved the
error you can click "Resolve" which will destroy the record.

![screenshot 1](https://github.com/npezza93/activeerror/blob/main/.github/screenshot1.png)
![screenshot 2](https://github.com/npezza93/activeerror/blob/main/.github/screenshot2.png)

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

Run the installer and migrate:
```bash
bin/rails active_error:install
bin/rails db:migrate
```

This will mount a route in your routes file to view the errors at `/errors`.

##### Config

You can supply a list of the string version of an error class to `ignored` to
ignore classes of errors.

```ruby
config.active_error.ignored = ["NoMethodError"]
```

You can supply a hash of connection options to `connects_to` set the connection
options for the base `ActiveError` model.

```ruby
config.active_error.connects_to = { database: { writing: :errors } }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rails test` to run the unit tests.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, execute `bin/publish (major|minor|patch)` which will
update the version number in `version.rb`, create a git tag for the version,
push git commits and tags, and push the `.gem` file to GitHub.

## Contributing

Bug reports and pull requests are welcome on
[GitHub](https://github.com/npezza93/activeerror). This project is intended to
be a safe, welcoming space for collaboration, and contributors are expected to
adhere to the [Contributor Covenant](http://contributor-covenant.org) code of
conduct.

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).
