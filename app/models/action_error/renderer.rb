# frozen_string_literal: true

module ActionError
  class Renderer
    def initialize(instance:)
      @instance = instance
      @exception = instance.fault.exception
    end

    def render
      [wrapper.status_code, headers, [body]]
    end

    def body
      @body ||= template.render(template: file, layout: "rescues/layout")
    end

    private

    attr_reader :exception, :instance

    delegate :trace_to_show, :source_to_show_id, :line_number, :source_extracts,
             :traces, to: :wrapper

    def backtrace_cleaner
      Rails.backtrace_cleaner
    end

    def format
      "text/html"
    end

    def wrapper
      @wrapper ||=
        ActionDispatch::ExceptionWrapper.new(backtrace_cleaner, exception)
    end

    def file
      "rescues/#{wrapper.rescue_template}"
    end

    def headers
      charset = ActionDispatch::Response.default_charset

      {
        "Content-Type" => "#{format}; charset=#{charset}",
        "Content-Length" => body.bytesize.to_s
      }
    end

    def template
      ActionDispatch::DebugView.new(
        request: instance.request, exception_wrapper: wrapper,
        exception: wrapper.exception, show_source_idx: source_to_show_id,
        trace_to_show: trace_to_show, line_number: line_number,
        source_extracts: source_extracts, traces: traces, file: wrapper.file,
      )
    end
  end
end
