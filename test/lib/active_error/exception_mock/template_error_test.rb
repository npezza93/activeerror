# frozen_string_literal: true

require "test_helper"

module ActiveError
  module ExceptionMock
    class TemplateErrorTest < ActiveSupport::TestCase
      setup do
        @fault = active_error_faults(:template)
        @mock = TemplateError.new(fault: @fault)
      end

      test "#class" do
        assert_equal ActionView::Template::Error, @mock.class
      end

      test "#backtrace" do
        assert_equal @fault.backtrace, @mock.backtrace
      end
    end
  end
end
