# frozen_string_literal: true

module ActiveError
ActiveJobRequest = Struct.new(:parameters, :filtered_parameters, :env, :url)

  class ErrorSubscriber
    def report(exception, context:, **_opts)
      return if Rails.env.local?

      Captor.new(exception:, request: context[:active_error_request]).capture
    end
  end

  class Engine < ::Rails::Engine
    isolate_namespace ActiveError

    initializer "active_error.middleware" do |_app|
      ActionController::Base.before_action do
        Rails.error.set_context(active_error_request: request)
      end
      Rails.error.subscribe(::ActiveError::ErrorSubscriber.new)
    end
  end
end

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
