# frozen_string_literal: true

module ActionError
  module Faults
    class Captor
      def initialize(exception:, env:, capture_instance: true)
        @exception = exception
        @env = env
        @capture_instance = capture_instance
      end

      def capture
        fault.instances.capture(env, capture_instance: capture_instance)

        fault
      end

      private

      attr_reader :exception, :env, :capture_instance

      def fault
        @fault ||= Fault.find_or_create_by(**fault_attrs) do |fault|
          fault.message = exception.message
          fault.extras = extras
          fault.cause = cause
        end
      end

      def params
        @params ||= ActionDispatch::Request.new(env).parameters
      end

      def fault_attrs
        { backtrace: exception.backtrace,
          klass: exception.class.to_s,
          blamed_files: exception.blamed_files,
          controller: params[:controller],
          action: params[:action] }
      end

      def extras
        case exception.class.to_s
        when "ActionView::Template::Error"
          { template: Marshal.dump(exception.instance_variable_get("@template")) }
        end
      end

      def cause
        return if exception.cause.blank?

        self.class.new(exception: exception.cause, env: env,
                       capture_instance: false).capture
      end
    end
  end
end
