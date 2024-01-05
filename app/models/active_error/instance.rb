# frozen_string_literal: true

require "useragent"

module ActiveError
  class Instance < ApplicationRecord
    belongs_to :fault, counter_cache: true

    serialize :parameters, coder: JSON
    serialize :headers, coder: JSON

    def self.capture(request, capture_instance:)
      return unless capture_instance

      headers = request.env.
                slice(*ActionDispatch::Request::ENV_METHODS, "HTTP_USER_AGENT")

      create(headers:, parameters: request.filtered_parameters,
             url: request.url)
    end

    delegate :browser, :platform, :version, to: :user_agent

    def user_agent_display
      "#{platform} #{browser} #{version}"
    end

    def request
      @request ||= ActionDispatch::Request.new(request_env)
    end

    private

    def user_agent
      @user_agent ||= UserAgent.parse(headers["HTTP_USER_AGENT"])
    end

    def request_env
      ENV.to_h.merge(headers).merge(
        "action_dispatch.request.parameters" => parameters,
      )
    end
  end
end
