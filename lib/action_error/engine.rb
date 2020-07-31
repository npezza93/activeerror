# frozen_string_literal: true

module ActionError
  class Engine < ::Rails::Engine
    isolate_namespace ActionError

    initializer "actionerror.middleware" do |app|
      app.config.middleware.use Middleware
    end
  end
end
