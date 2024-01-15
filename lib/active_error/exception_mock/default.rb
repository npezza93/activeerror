# frozen_string_literal: true

# require "active_support/dependencies"

module ActiveError
  module ExceptionMock
    class Klass < SimpleDelegator
      def name
        self
      end
    end

    class Default < StandardError
      # include ActiveSupport::Dependencies::Blamable

      def initialize(fault:)
        @klass = fault.klass
        @backtrace = fault.backtrace
        @backtrace_locations = fault.backtrace_locations
        @message = fault.message
        # @blamed_files = fault.blamed_files
        @cause = ExceptionMock.make(fault: fault.cause)
      end

      def class
        Klass.new(klass)
      end

      attr_reader :backtrace, :backtrace_locations, :message, :cause,
                  :line_number

      private

      attr_reader :klass
    end
  end
end
