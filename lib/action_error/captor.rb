# frozen_string_literal: true

module ActionError
  class Captor
    def initialize(exception:, env:, capture_instance: true)
      @exception = exception
      @env = env
      @capture_instance = capture_instance
    end

    def capture
      fault.instances.capture(request, capture_instance: capture_instance)

      fault
    end

    private

    attr_reader :exception, :env, :capture_instance

    delegate :parameters, to: :request

    def fault
      @fault ||= Fault.default_scoped.find_or_create_by(fault_attrs) do |fault|
        fault.message = exception.message
        fault.cause = cause
        options(fault)
      end
    end

    def request
      @request ||= ActionDispatch::Request.new(env)
    end

    def fault_attrs
      { backtrace: exception.backtrace,
        klass: exception.class.to_s,
        blamed_files: exception.blamed_files,
        controller: parameters[:controller],
        action: parameters[:action] }
    end

    def options(fault)
      case exception.class.to_s
      when "ActionView::Template::Error"
        fault.template = exception.instance_variable_get("@template")
      end
    end

    def cause
      return if exception.cause.blank?

      self.class.new(exception: exception.cause, env: env,
                     capture_instance: false).capture
    end
  end
end
