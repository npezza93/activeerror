# frozen_string_literal: true

module ActionError
  module ExceptionMock
    class TemplateError < ActionView::Template::Error
      def initialize(fault:)
        @klass = fault.klass
        set_backtrace(fault.backtrace)
        @message = fault.message
        @blamed_files = fault.blamed_files
        @template = Marshal.load(fault.options[:template])
        @cause = ExceptionMock.make(fault: fault.cause) if fault.cause.present?
      end

      def class
        klass.constantize
      end

      attr_reader :message

      private

      attr_reader :klass
    end
  end
end
