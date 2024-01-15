# frozen_string_literal: true

require "test_helper"

module ActiveError
  module ExceptionMock
    class DefaultTest < ActiveSupport::TestCase
      setup do
        @fault = active_error_faults(:one)
        @mock = Default.new(fault: @fault)
      end

      test "#class" do
        assert_equal "NoMethodError", @mock.class
      end

      test "#backtrace" do
        assert_equal @fault.backtrace, @mock.backtrace
      end

      test "#cause" do
        assert_equal @fault.cause.klass, @mock.cause.class
        assert_instance_of Default, @mock.cause
      end
    end
  end
end
