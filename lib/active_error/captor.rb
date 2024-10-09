# frozen_string_literal: true

module ActiveError
  BacktraceLocation = Struct.new(:absolute_path, :base_label, :to_s, :label,
                                 :lineno, :path) do
    def inspect = to_s

    def spot(exception)
    end
  end

  class Captor
    def initialize(exception:, request:)
      @exception = exception
      @request = request
    end

    def capture
      create_instance
      fault
    end

    private

    attr_reader :exception, :request, :capture_instance

    delegate :parameters, to: :request, allow_nil: true

    def fault
      @fault ||= Fault.default_scoped.find_or_create_by(fault_attrs) do |fault|
        fault.message = exception.message
        fault.cause = cause
        fault.backtrace_locations = backtrace_locations
        fault.template = template if template?
      end
    end

    def fault_attrs
      { backtrace: exception.backtrace, klass: exception.class.to_s,
        controller:, action: controller_action }
    end

    def template?
      exception.is_a?(ActionView::Template::Error) ||
        exception.class.is_a?(ActionView::Template::Error)
    end

    def template
      exception.instance_variable_get(:@template)
    end

    def cause
      return if exception.cause.blank?

      self.class.new(exception: exception.cause, request:,
                     capture_instance: false).capture
    end

    def backtrace_locations
      exception.backtrace_locations&.map do |location|
        BacktraceLocation.new(location.absolute_path, location.base_label,
                              location.to_s, location.label, location.lineno,
                              location.path)
      end
    end

    def create_instance
      headers = request&.env.to_h.
                slice(*ActionDispatch::Request::ENV_METHODS, "HTTP_USER_AGENT")

      fault.instances.create(headers:, parameters: request&.filtered_parameters,
                             url: request&.url)
    end

    def controller
      parameters.to_h[:controller].presence ||
        request.try(:controller_class).to_s.presence
    end

    def controller_action
      parameters.to_h[:action].presence ||
        request.try(:controller_instance).try(:action_name).presence
    end
  end
end
