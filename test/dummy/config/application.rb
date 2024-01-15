# frozen_string_literal: true

require_relative "boot"

%w(
  active_record/railtie
  action_controller/railtie
  action_view/railtie
  active_support/railtie
  active_job/railtie
  rails/test_unit/railtie
).each do |railtie|
  require railtie
end

Bundler.require(*Rails.groups)
require "active_error"

module Dummy
  class Application < Rails::Application
    config.load_defaults "#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}"

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
