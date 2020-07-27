# frozen_string_literal: true

Rails.application.routes.draw do
  mount ActionError::Engine => "/action_error"
end
