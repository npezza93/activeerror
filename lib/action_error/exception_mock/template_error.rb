# frozen_string_literal: true

require "action_view/template/error"

module ActionError
  module ExceptionMock
    class TemplateError < ActionView::Template::Error
      def initialize(fault:)
        @klass = fault.klass
        set_backtrace(fault.backtrace)
        @message = fault.message
        @blamed_files = fault.blamed_files
        @template = fault.template
        @cause = ExceptionMock.make(fault: fault.cause)
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
