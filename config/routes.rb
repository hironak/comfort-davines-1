Commers::Application.routes.draw do

  devise_for :dealers

  devise_for :users

  root to: "welcome#index"

  resources :merchandises

  resources :products

end
