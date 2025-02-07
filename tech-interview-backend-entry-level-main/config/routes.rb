require "sidekiq/web"

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"
  # product routes
  resources :products

  # cart routes
  resources :cart, only: [:show, :create] do
    member do
      delete ":product_id", to: "carts#destroy" # Rota para remover um produto do carrinho
    end

    collection do
      patch "add_item", to: "carts#update" # Rota personalizada para atualizar a quantidade de um produto
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check

  root "rails/health#show"
end
