# frozen_string_literal: true

require "test_helper"

module ActiveError
  module Faults
    class InstancesControllerTest < ActionDispatch::IntegrationTest
      test "#show" do
        instance = active_error_instances(:one)
        get active_error.fault_instance_path(instance.fault, instance)

        assert_response :success
      end
    end
  end
end
