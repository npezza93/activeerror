# frozen_string_literal: true

module ActionError
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      @app.call(env)
    rescue Exception => e # rubocop:disable Lint/RescueException
      captor = Captor.new(exception: e, env:)
      captive = captor.capture

      raise e unless captor.display?

      Renderer.new(instance: captive.instance).render
    end
  end
end
