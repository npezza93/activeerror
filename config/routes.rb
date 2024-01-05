# frozen_string_literal: true

ActiveError::Engine.routes.draw do
  resources :faults, only: %i(index show destroy) do
    scope module: :faults do
      resources :instances, only: :show
    end
  end

  root "faults#index"
end
