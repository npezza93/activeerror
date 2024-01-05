# frozen_string_literal: true

require "test_helper"

module ActiveError
  class RendererTest < ActiveSupport::TestCase
    test "#body" do
      body = Renderer.new(instance: active_error_instances(:one)).body
      expected = "<body> <header> <h1> NoMethodError in " \
                 "ActiveError::Faults::InstancesController#show </h1> </header>"

      assert_equal body.squish.match(/<body>.*<\/header>/).to_s, expected
    end

    test "#body template error" do
      body = Renderer.new(instance: active_error_instances(:template)).body
      expected = "<body> <header role=\"banner\"> <h1> StandardError in " \
                 "ActiveError::Faults::Instances#show </h1> </header>"

      assert_equal body.squish.match(/<body>.*<\/header>/).to_s, expected
    end
  end
end
