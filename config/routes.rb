Commers::Application.routes.draw do

  root to: "welcome#index"

  devise_for :consumers, :controllers => {
    :sessions => "sessions"
  }

  resources :products, only: [:index, :show]

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
