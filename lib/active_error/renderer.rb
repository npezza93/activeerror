# frozen_string_literal: true

module ActiveError
  class Renderer
    def initialize(instance:)
      @instance = instance
      @exception = instance.fault.exception
    end

    def body
      @body ||= begin
        set_lookup_context

        template.render(template: file, layout: "active_error/rescue")
      end
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
      @template ||=
        ActionDispatch::DebugView.
        new(request: instance.request, exception_wrapper:, traces:,
            exception: exception_wrapper.exception, trace_to_show:,
            source_extracts:, show_source_idx: source_to_show_id,)
    end

    def set_lookup_context
      template.define_singleton_method :lookup_context= do |new_context|
        @lookup_context = new_context
        @view_renderer = ActionView::Renderer.new @lookup_context
      end

      template.lookup_context = new_lookup_context
    end

    def new_lookup_context
      ActionView::LookupContext.new([
        *ActionDispatch::DebugView::RESCUES_TEMPLATE_PATHS.dup,
        ActiveError::Engine.root.join("app/views/layouts").to_s
      ])
    end
  end
end
