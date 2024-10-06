# frozen_string_literal: true

module ActiveError
  ActiveJobRequest = Struct.new(:parameters, :filtered_parameters,
                                :controller_class, :env, :url)

  class Engine < ::Rails::Engine
    isolate_namespace ActiveError

    config.active_error = ActiveSupport::OrderedOptions.new

    initializer "active_error.error_reporter" do |_app|
      Rails.error.subscribe(::ActiveError::ErrorSubscriber.new)
    end

    initializer "active_error.config" do
      config.active_error.each do |name, value|
        ActiveError.public_send(:"#{name}=", value)
      end
    end

    initializer "active_error.context" do
      ActionController::Base.before_action do
        Rails.error.set_context(active_error_request: request)
      end

      ActiveJob::Base.before_perform do
        Rails.error.set_context(active_error_request:
          ActiveJobRequest.new(serialize, serialize, self.class.name))
      rescue ActiveJob::SerializationError
        without_args = { "job_class" => self.class.name,
                         "job_id" => job_id,
                         "provider_job_id" => provider_job_id,
                         "queue_name" => queue_name,
                         "priority" => priority,
                         "executions" => executions,
                         "exception_executions" => exception_executions,
                         "locale" => I18n.locale.to_s,
                         "timezone" => timezone,
                         "enqueued_at" => Time.now.utc.iso8601(9),
                         "scheduled_at" => scheduled_at&.utc&.iso8601(9) }
        Rails.error.set_context(active_error_request:
          ActiveJobRequest.new(without_args, without_args, self.class.name))
      end
    end
  end
end
