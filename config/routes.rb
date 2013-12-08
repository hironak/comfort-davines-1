Commers::Application.routes.draw do

  root to: "welcome#index"

  devise_for :users

  namespace :admin, module: :administration do

    resources :merchandises

    resources :products

    # Session
    delete "logout" => "sessions#destroy"
    get "login" => "sessions#new"
    post "login" => "sessions#create"

    # Admin root
    root to: "dashboard#index"
  end
end
