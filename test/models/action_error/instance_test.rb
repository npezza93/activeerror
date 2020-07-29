# frozen_string_literal: true

require "test_helper"

module ActionError
  class InstanceTest < ActiveSupport::TestCase
    test "#user_agent_display" do
      assert_equal(
        "Macintosh Safari 13.1.2",
        action_error_instances(:one).user_agent_display
      )
    end

    test "#request" do
      assert_instance_of(
        ActionDispatch::Request,
        action_error_instances(:one).request
      )
    end
  end
end
