# frozen_string_literal: true

Rails.application.routes.draw do
  mount ActiveError::Engine => "/errors"

  resources :make_errors, only: :new
end
