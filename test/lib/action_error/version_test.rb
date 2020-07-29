# frozen_string_literal: true

require "test_helper"

module ActionError
  class VersionTest < ActiveSupport::TestCase
    test "VERSION" do
      assert_instance_of(Gem::Version, ActionError::VERSION)
    end
  end
end
