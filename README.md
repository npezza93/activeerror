# ActiveError

One of the fundemental tools needed to take your Rails app to production is a
way to track errors that are triggered. Unfortunately, theres no free, easy,
open source way to track them for small or medium apps. Honeybadger and Sentry are great,
but they are only free for a single user and are closed source. With Sentry
looking at using your data as training
data([link](https://blog.sentry.io/ai-privacy-and-terms-of-service-updates/?original_referrer=https%3A%2F%2Fsentry.io%2F))
there should be an easy open source alternative where you control the data.

ActiveError hooks into the [error reporting
api](https://guides.rubyonrails.org/error_reporting.html) baked directly into
Rails. These third party error loggers also try to make their own fancy
backtrace and debugging view. But the one Rails developers are most comfortable
with is the one baked into Rails that we use everyday in development. So with
ActiveError, when an error gets raised it's captured and stored in the
database (we attempt to group the same error together as Instances to reduce
noise) and then we recreate the error and display it using the built in debug
view from Rails. Once you've resolved the error you can click "Resolve" with
will destroy the record.

![screenshot 1](https://github.com/npezza93/active_error/blob/main/.github/screenshot1.png)
![screenshot 2](https://github.com/npezza93/active_error/blob/main/.github/screenshot2.png)

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
