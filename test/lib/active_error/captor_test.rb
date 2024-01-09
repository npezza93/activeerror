# frozen_string_literal: true

require "test_helper"

module ActiveError
  class CaptorTest < ActiveSupport::TestCase
    test "captures exception" do
      request = ActionDispatch::TestRequest.create
      exception = NoMethodError.new("method doesnt exist")
      captor = Captor.new(exception:, request:)

      assert_difference -> { Fault.count } do
        assert_difference -> { Instance.count } do
          captive = captor.capture
          assert_instance_of Fault, captive
        end
      end
    end

    test "captures template error" do
      template = active_error_faults(:template).template
      request = ActionDispatch::TestRequest.create
      exception = nil
      begin
        raise NoMethodError
      rescue NoMethodError
        exception = ActionView::Template::Error.new(template)
      end

      captor = Captor.new(exception:, request:)

      assert_difference -> { Fault.count }, 2 do
        assert_difference -> { Instance.count } do
          captive = captor.capture
          assert_instance_of Fault, captive
          assert_instance_of Fault, captive.cause
        end
      end
    end
  end
end
