Commers::Application.routes.draw do

  root to: "welcome#index"

  devise_for :users

  resources :merchandises

  resources :products

  namespace :admin do
  end
end
