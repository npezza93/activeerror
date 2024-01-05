# frozen_string_literal: true

module ActiveError
  class Engine < ::Rails::Engine
    isolate_namespace ActiveError

    initializer "active_error.middleware" do |app|
      app.config.middleware.use ActiveError::Middleware
    end
  end
end
