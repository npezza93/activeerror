# frozen_string_literal: true

module ActiveError
  Captive = Struct.new(:fault, :instance)
  BacktraceLocation = Struct.new(:absolute_path, :base_label, :to_s, :label, # rubocop:disable Lint/StructNewOverride
                                 :lineno, :path) do
    def inspect = to_s

    if defined?(ErrorHighlight) &&
        Gem::Version.new(ErrorHighlight::VERSION) >= Gem::Version.new("0.4.0")
      def spot(exception)
        ErrorHighlight.spot(exception, backtrace_location: self)
      end
    else
      def spot(exception)
      end
    end
  end

  class Captor
    def initialize(exception:, env:, capture_instance: true)
      @exception = exception
      @env = env
      @capture_instance = capture_instance
    end

    def capture
      Captive.new(
        fault,
        fault.instances.capture(request, capture_instance:)
      )
    end

    def display?
      ActiveRecord::Type::Boolean.new.cast(parameters["active_error.display"])
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
        backtrace_locations:,
        klass: exception.class.to_s,
        controller: parameters[:controller],
        action: parameters[:action] }
    end

    def options(fault)
      case exception.class.to_s
      when "ActionView::Template::Error"
        fault.template = exception.instance_variable_get(:@template)
      end
    end

    def cause
      return if exception.cause.blank?

      self.class.new(exception: exception.cause, env:,
                     capture_instance: false).capture.fault
    end

    def backtrace_locations
      exception.backtrace_locations&.map do |location|
        BacktraceLocation.new(location.absolute_path, location.base_label,
                              location.to_s, location.label, location.lineno,
                              location.path)
      end
    end
  end
end
