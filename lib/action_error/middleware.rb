# frozen_string_literal: true

module ActionError
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      @app.call(env)
    rescue Exception => e # rubocop:disable Lint/RescueException
      Captor.new(exception: e, env: env).capture
      # ErrorRenderer.new(exception: e, env: env).render
      raise e
    end
  end
end
