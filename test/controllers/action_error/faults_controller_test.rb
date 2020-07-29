# frozen_string_literal: true

require "test_helper"

module ActionError
  class FaultsControllerTest < ActionDispatch::IntegrationTest
    test "#index" do
      get action_error.faults_path
      assert_response :success
    end

    test "#show" do
      get action_error.fault_path(action_error_faults(:one))

      assert_response :success
    end

    test "#destroy" do
      assert_difference -> { ActionError::Fault.count }, -2 do
        assert_difference -> { ActionError::Instance.count }, -1 do
          delete action_error.fault_path(action_error_faults(:template))
        end
      end

      assert_redirected_to action_error.faults_path
    end
  end
end
