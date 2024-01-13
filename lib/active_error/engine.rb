# frozen_string_literal: true

module ActiveError
  ActiveJobRequest = Struct.new(:parameters, :filtered_parameters, :env, :url)

  class Engine < ::Rails::Engine
    isolate_namespace ActiveError

    initializer "active_error.middleware" do |_app|
      ActionController::Base.before_action do
        Rails.error.set_context(active_error_request: request)
      end

      ActiveJob::Base.before_perform do
        Rails.error.set_context(active_error_request:
          ActiveJobRequest.new(serialize, serialize))
      end
    end
  end
end
