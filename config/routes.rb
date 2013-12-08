Commers::Application.routes.draw do

  root to: "welcome#index"

  devise_for :users

  resources :merchandises

  resources :products

  namespace :admin, module: :administration do
    root to: "dashboard#index"
  end
end
