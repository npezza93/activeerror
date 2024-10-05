# frozen_string_literal: true

require "test_helper"

module ActiveError
  class FaultsControllerTest < ActionDispatch::IntegrationTest
    test "#index" do
      get active_error.faults_path
      assert_response :success
    end

    test "#destroy" do
      assert_difference -> { Fault.count }, -2 do
        assert_difference -> { Instance.count }, -1 do
          delete active_error.fault_path(active_error_faults(:template))
        end
      end

      assert_redirected_to active_error.faults_path
    end
  end
end
