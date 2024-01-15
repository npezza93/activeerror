# frozen_string_literal: true

require "test_helper"

module ActiveError
  class ErrorSubscriberTest < ActiveSupport::TestCase
    test "ignores exception" do
      request = ActionDispatch::TestRequest.create
      exception = NoMethodError.new("method doesnt exist")
      ActiveError.ignored = ["NoMethodError"]

      assert_no_difference -> { Fault.count } do
        ActiveError::ErrorSubscriber.new.report(
          exception, context: { active_error_request: request }, handled: false
        )
      end
    end
  end
end
