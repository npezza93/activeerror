# frozen_string_literal: true

module ActiveError
  class ErrorSubscriber
    def report(exception, context:, handled:, **_opts)
      return if Rails.env.development? || handled ||
        ActiveError.ignored.to_a.include?(exception.class.to_s)

      Captor.new(exception:, request: context[:active_error_request]).capture
    end
  end

  class Railtie < ::Rails::Railtie
    initializer "active_error.error_reporter" do |_app|
      Rails.error.subscribe(::ActiveError::ErrorSubscriber.new)
    end
  end
end
