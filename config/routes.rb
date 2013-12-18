Commers::Application.routes.draw do

  root to: "welcome#index"

  devise_for :consumers, :controllers => {
    :sessions => "sessions"
  }

  resources :products, only: [:index, :show]

  resources :carts, only: [:index] do
    collection do
      post "add"
      patch "increment"
      patch "decrement"
      delete "remove"
    end
  end

  namespace :cashier do
    get "order"
    post "order", action: "order_create"

    get "payment"
    post "payment", action: "payment_create"

    get "confirm"
    post "confirm", action: "confirm_create"

    get "complete"
  end

  namespace :admin, module: :administration do

    resources :merchandises

    resources :products

    resources :administrators

    # Session
    delete "logout" => "sessions#destroy"
    get "login" => "sessions#new"
    post "login" => "sessions#create"

    # Admin root
    root to: "dashboard#index"
  end
end
