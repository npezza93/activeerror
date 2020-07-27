# frozen_string_literal: true

module ActionError
  class Instance < ApplicationRecord
    belongs_to :fault, counter_cache: true

    serialize :parameters, Hash
    serialize :headers, Hash

    def self.capture(env, capture_instance:)
      return unless capture_instance

      request = ActionDispatch::Request.new(env)
      headers = env.slice(
        *ActionDispatch::Request::ENV_METHODS, "HTTP_USER_AGENT"
      )

      create(headers: headers, parameters: request.filtered_parameters,
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
      ENV.to_h.merge(
        "action_dispatch.request.parameters" => parameters,
        **headers
      )
    end
  end
end
