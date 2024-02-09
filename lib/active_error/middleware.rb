# frozen_string_literal: true

module ActiveError
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      @app.call(env)
    rescue StandardError => e
      unless Rails.application.config.reloading_enabled?
        Rails.error.report(e, handled: false,
                              source: "application.action_dispatch")
      end
      raise
    end
  end
end
