# frozen_string_literal: true

module ActiveError
  class ErrorSubscriber
    def report(exception, handled:, severity:, context:, source: nil)
      Captor.new(exception:, request: context[:active_error_request]).capture
    end
  end
end
