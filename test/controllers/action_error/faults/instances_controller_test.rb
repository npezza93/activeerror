# frozen_string_literal: true

require "test_helper"

module ActionError
  module Faults
    class InstancesControllerTest < ActionDispatch::IntegrationTest
      test "#show" do
        instance = action_error_instances(:one)
        get action_error.fault_instance_path(instance.fault, instance)

        assert_response :success
      end
    end
  end
end
