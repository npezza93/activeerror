# frozen_string_literal: true

module ActiveError
  class ErrorSubscriber
    def report(exception, context:, **_opts)
      return if !ActiveError.enabled? ||
        ActiveError.ignored_classes.include?(exception.class.to_s)

      Captor.new(exception:, request: context[:active_error_request]).capture
    end
  end
end
