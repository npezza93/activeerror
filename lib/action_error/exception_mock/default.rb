# frozen_string_literal: true

require "active_support/dependencies"

module ActionError
  module ExceptionMock
    class Default
      include ActiveSupport::Dependencies::Blamable

      def initialize(fault:)
        @klass = fault.klass
        @backtrace = fault.backtrace
        @message = fault.message
        @blamed_files = fault.blamed_files
        @cause = ExceptionMock.make(fault: fault.cause)
      end

      def class
        klass.constantize
      end

      attr_reader :backtrace, :message, :cause

      private

      attr_reader :klass
    end
  end
end
