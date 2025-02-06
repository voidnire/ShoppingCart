require "sidekiq/web"

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"
  resources :products

  # cart routes
  resource :cart, only: [:show, :create, :update, :destroy], controller: "carts"

  get "up" => "rails/health#show", as: :rails_health_check

  root "rails/health#show"
end
