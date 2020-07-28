# frozen_string_literal: true

module ActionError
  module ExceptionMock
    class Default
      include ActiveSupport::Dependencies::Blamable

      def initialize(fault:)
        @klass = fault.klass
        @backtrace = fault.backtrace
        @message = fault.message
        @blamed_files = fault.blamed_files
        @cause = ExceptionMock.make(fault: fault.cause) if fault.cause.present?
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
