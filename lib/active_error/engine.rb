# frozen_string_literal: true

module ActiveError
  class Engine < ::Rails::Engine
    ActiveJobRequest = Struct.new(:parameters, :filtered_parameters, :env, :url)

    isolate_namespace ActiveError

    initializer "active_error.middleware" do |app|
      unless Rails.env.local?
        app.config.middleware.use ActiveError::Middleware

        ::ActiveJob::Base.class_eval do |base|
          base.set_callback :perform, :around do |_param, block|
            block.call
          rescue StandardError => e
            ActiveError::Captor.new(exception: e, request: ActiveJobRequest.new(
              serialize, serialize
            )).capture
            raise e
          end
        end
      end
    end
  end
end
