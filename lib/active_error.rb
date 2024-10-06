# frozen_string_literal: true

require "active_error/error_subscriber"
require "active_error/exception_mock/default"
require "active_error/exception_mock/template_error"
require "active_error/exception_mock"
require "active_error/captor"
require "active_error/renderer"
require "active_error/engine"
require "active_error/version"

module ActiveError
  mattr_accessor :ignored, :enabled

  IGNORE_DEFAULT = [
    "AbstractController::ActionNotFound",
    "ActionController::BadRequest",
    "ActionController::InvalidAuthenticityToken",
    "ActionController::InvalidCrossOriginRequest",
    "ActionController::MethodNotAllowed",
    "ActionController::NotImplemented",
    "ActionController::ParameterMissing",
    "ActionController::RoutingError",
    "ActionController::UnknownAction",
    "ActionController::UnknownFormat",
    "ActionDispatch::Http::MimeNegotiation::InvalidType",
    "ActionController::UnknownHttpMethod",
    "ActionDispatch::Http::Parameters::ParseError",
    "ActiveRecord::RecordNotFound"
  ].freeze

  class << self
    def ignored_classes
      ignored.to_a + IGNORE_DEFAULT
    end

    def enabled?
      if enabled.nil?
        !Rails.env.local?
      else
        enabled.present?
      end
    end
  end
end
