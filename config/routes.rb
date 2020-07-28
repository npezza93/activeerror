# frozen_string_literal: true

ActionError::Engine.routes.draw do
  resources :faults, only: %i(index show destroy) do
    resources :instances, only: :show
  end
  root "faults#index"
end
