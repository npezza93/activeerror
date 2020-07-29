# frozen_string_literal: true

require "test_helper"

module ActionError
  class ExceptionMockTest < ActiveSupport::TestCase
    test ".make with nil" do
      assert_nil ExceptionMock.make(fault: nil)
    end

    test ".make with default" do
      assert_instance_of(
        ExceptionMock::Default,
        ExceptionMock.make(fault: action_error_faults(:one))
      )
    end

    test ".make with tempalte error" do
      template = action_error_faults(:template)

      assert_instance_of(
        ExceptionMock::TemplateError,
        ExceptionMock.make(fault: template)
      )
    end
  end
end
