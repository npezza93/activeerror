# frozen_string_literal: true

module ActiveError
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      @app.call(env)
    rescue Exception => exception # rubocop:disable Lint/RescueException, Naming/RescuedExceptionsVariableName
      captor = Captor.new(exception:, env:)
      captive = captor.capture

      raise exception unless captor.display?

      Renderer.new(instance: captive.instance).render
    end
  end
end
