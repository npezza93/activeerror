# frozen_string_literal: true

require "test_helper"

module ActionError
  class CaptorTest < ActiveSupport::TestCase
    test "captures exception" do
      request = ActionDispatch::TestRequest.create
      exception = NoMethodError.new("method doesnt exist")
      captor = ActionError::Captor.new(exception: exception, env: request.env)

      assert_difference -> { Fault.count } do
        assert_difference -> { Instance.count } do
          assert_instance_of Fault, captor.capture
        end
      end
    end

    test "captures template error" do
      template = action_error_faults(:template).template
      request = ActionDispatch::TestRequest.create
      exception = nil
      begin
        raise NoMethodError
      rescue NoMethodError
        exception = ActionView::Template::Error.new(template)
      end

      captor = ActionError::Captor.new(exception: exception, env: request.env)

      assert_difference -> { Fault.count }, 2 do
        assert_difference -> { Instance.count } do
          fault = captor.capture
          assert_instance_of Fault, fault
          assert_instance_of Fault, fault.cause
        end
      end
    end
  end
end
