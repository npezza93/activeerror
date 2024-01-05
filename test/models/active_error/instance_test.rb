# frozen_string_literal: true

require "test_helper"

module ActiveError
  class InstanceTest < ActiveSupport::TestCase
    test "#user_agent_display" do
      assert_equal(
        "Macintosh Safari 13.1.2",
        active_error_instances(:one).user_agent_display
      )
    end

    test "#request" do
      assert_instance_of(
        ActionDispatch::Request,
        active_error_instances(:one).request
      )
    end
  end
end
