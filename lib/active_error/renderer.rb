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
             :traces, to: :wrapper

    def backtrace_cleaner
      Rails.backtrace_cleaner
    end

    def wrapper
      @wrapper ||=
        ActionDispatch::ExceptionWrapper.new(backtrace_cleaner, exception)
    end

    def file
      "rescues/#{wrapper.rescue_template}"
    end

    def template
      ActionDispatch::DebugView.new(
        request: instance.request, exception_wrapper: wrapper,
        exception: wrapper.exception, traces:,
        show_source_idx: source_to_show_id, trace_to_show:, source_extracts:
      )
    end
  end
end
