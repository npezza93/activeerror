# frozen_string_literal: true

require "test_helper"

module ActiveError
  class RendererTest < ActiveSupport::TestCase
    test "#body" do
      body = Renderer.new(instance: active_error_instances(:one)).body
      expected = "<body>\n\n<header>\n  <h1>\n    NoMethodError\n      " \
                 "in ActiveError::Faults::InstancesController#show\n  </h1>" \
                 "\n</header>"

      assert_includes body, expected
    end

    test "#body template error" do
      body = Renderer.new(instance: active_error_instances(:template)).body
      expected = "<body>\n\n<header>\n  <h1>\n    StandardError in\n    " \
                 "ActiveError::Faults::Instances#show\n  </h1>\n</header>"

      assert_includes body, expected
    end
  end
end
