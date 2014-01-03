Commers::Application.routes.draw do

  # トップページ
  root to: "welcome#index"

  # 表側ユーザ
  devise_for :consumers, :controllers => {
    :sessions => "sessions"
  }

  # 商品一覧、詳細ページ
  resources :products, only: [:index, :show]

  # カート
  resources :carts, only: [:index] do
    collection do
      post "add"
      patch "increment"
      patch "decrement"
      delete "remove"
    end
  end

  # 注文
  namespace :cashier do
    get "", action: "index"

    get "signature"
    post "signature", action: "signature_create"

    get "sample"
    post "sample", action: "sample_create"

    get "order"
    post "order", action: "order_create"

    get "payment"
    post "payment", action: "payment_create"

    get "confirm"
    post "confirm", action: "confirm_create"

    get "complete"
  end

  # 裏側
  namespace :admin, module: :administration do

    # Admin root
    root to: "dashboard#index"

    # Session
    delete "logout" => "sessions#destroy"
    get "login" => "sessions#new"
    post "login" => "sessions#create"

    # 商品マスタ管理
    resources :products
    resources :categories
    resources :serieses

    # 注文管理
    resources :orders, except: [:new, :create]

    # 裏側ユーザ管理
    resources :administrators

    # ページ編集
    resources :pages

    # File Storage
    resources :file_storages
  end
end
