# frozen_string_literal: true

module ActiveError
  class Renderer
    def initialize(instance:)
      @instance = instance
      @exception = instance.fault.exception
    end

    def body
      @body ||= template.render(template: file, layout: "rescues/layout")
    end

    private

    attr_reader :exception, :instance

    delegate :trace_to_show, :source_to_show_id, :source_extracts,
             :traces, to: :exception_wrapper

    def exception_wrapper
      @exception_wrapper ||=
        ActionDispatch::ExceptionWrapper.new(Rails.backtrace_cleaner, exception)
    end

    def file
      "rescues/#{exception_wrapper.rescue_template}"
    end

    def template
      ActionDispatch::DebugView.
        new(request: instance.request, exception_wrapper:, traces:,
            exception: exception_wrapper.exception, trace_to_show:,
            source_extracts:, show_source_idx: source_to_show_id,)
    end
  end
end
