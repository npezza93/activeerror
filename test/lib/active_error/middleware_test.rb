# frozen_string_literal: true

require "test_helper"

class CustomException < StandardError
end

module ActiveError
  class MiddlewareTest < ActiveSupport::TestCase
    setup do
      @env = ActionDispatch::TestRequest.create.env
    end

    test "#call" do
      app = ->(env) { ["response", {}, env] }

      response = Middleware.new(app).call(@env)
      assert_equal ["response", {}, @env], response
    end

    test "#call with exception" do
      exception = CustomException.new("foobar")
      app = ->(_env) { raise exception }

      begin
        Middleware.new(app).call(@env)
      rescue StandardError => e
        assert_equal exception, e
      else
        flunk "Didn't raise an exception"
      end
    end

    test "#call with exception and display" do
      @env["action_dispatch.request.parameters"] =
        { "active_error.display" => 1 }
      exception = CustomException.new("foobar")
      app = ->(_env) { raise exception }

      response = Middleware.new(app).call(@env)
      assert_equal 500, response[0]
      assert_equal "text/html; charset=UTF-8", response[1]["Content-Type"]
      assert response[1].key? "Content-Length"
      assert Nokogiri::HTML.parse(response[2][0]).at("body").present?
    end
  end
end
