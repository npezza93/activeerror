# frozen_string_literal: true

module ActiveError
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      @app.call(env)
    rescue Exception => exception # rubocop:disable Lint/RescueException, Naming/RescuedExceptionsVariableName
      Captor.new(exception:, request: env.request).capture

      raise
    end
  end
end
