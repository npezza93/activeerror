# frozen_string_literal: true

require "test_helper"

module ActiveError
  class FaultTest < ActiveSupport::TestCase
    test "#title" do
      fault = Fault.new(klass: "NoMethodError")
      assert_equal "NoMethodError", fault.title

      fault.controller = "FaultsController"
      assert_equal "NoMethodError in FaultsController", fault.title

      fault.action = "index"
      assert_equal "NoMethodError in FaultsController#index", fault.title
    end

    test "#occurrences" do
      fault = Fault.new(instances_count: 1)
      assert_equal "1 instance", fault.occurrences

      fault = Fault.new(instances_count: 2)
      assert_equal "2 instances", fault.occurrences
    end

    test "#template" do
      fault = active_error_faults(:template)

      assert_instance_of ActionView::Template, fault.template

      fault = active_error_faults(:one)

      assert_nil fault.template
    end

    test ".top_level" do
      parent = active_error_faults(:one)
      child = parent.cause
      top_level = Fault.top_level

      assert_includes top_level, parent
      assert_not_includes top_level, child
    end
  end
end
