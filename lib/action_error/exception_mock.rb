# frozen_string_literal: true

module ActionError
  module ExceptionMock
    def self.make(fault:)
      case fault&.klass
      when "ActionView::Template::Error" then TemplateError.new(fault: fault)
      when nil then nil
      else
        Default.new(fault: fault)
      end
    end
  end
end
