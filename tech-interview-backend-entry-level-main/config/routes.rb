require "sidekiq/web"

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"
  # product routes
  resources :products

  # cart routes
  resources :cart, only: [:show, :create] do
    collection do
      delete ":product_id", to: "carts#destroy" # remover um produto do carrinho
      patch "add_item", to: "carts#update" # atualizar a quantidade de um produto
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check

  root "rails/health#show"
end
