Commers::Application.routes.draw do

  root to: "welcome#index"

  devise_for :dealers

  devise_for :users

  resources :merchandises

  resources :products

end
