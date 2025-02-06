require "sidekiq/web"

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"
  # product routes
  resources :products

  # cart routes
  resources :carts, only: [:show, :create] do
    member do
      delete ":product_id", to: "carts#destroy" #
    end

    collection do
      delete "cleanup_abandoned", to: "carts#cleanup_abandoned"
    end #tirar dps
  end

  get "up" => "rails/health#show", as: :rails_health_check

  root "rails/health#show"
end
