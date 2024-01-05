# frozen_string_literal: true

require "test_helper"

module ActiveError
  class VersionTest < ActiveSupport::TestCase
    test "VERSION" do
      assert_instance_of(Gem::Version, ActiveError::VERSION)
    end
  end
end
