# frozen_string_literal: true

module ActionError
  module ExceptionMock
    def self.make(fault:)
      case fault.klass
      when "ActionView::Template::Error"
        TemplateError
      else
        Default
      end.new(fault: fault)
    end
  end
end
