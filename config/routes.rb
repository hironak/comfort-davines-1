Commers::Application.routes.draw do

  get "editable/stylesheets/:key", to: "editable#stylesheets"

  # 表側ユーザ
  devise_for :consumers, :controllers => {
    :sessions => "sessions"
  }

  # トップページ
  controller :welcome do
    root action: "index"
    get "introduction", action: "introduction"
    get "about", action: "about"
    get "utilization", action: "utilization"
    get "faq", action: "faq"
    get "sitemap", action: "sitemap"
    get "contact", action: "contact"
    get "company", action: "company"
    get "tradeinfo", action: "tradeinfo"
    get "shops", action: "shops"
  end

  namespace :mypage do
    root action: :index
    get "orders"
  end

  # 商品一覧、詳細ページ
  resources :products, only: [:index, :show] do
    collection do
      get :category
      get :series
      get :new_items
    end
  end

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

  # サロン情報
  resources :salons, only: [:index]

  # 裏側
  namespace :admin, module: :administration do

    # Admin root
    root to: "dashboard#index"

    # Setting
    resource :setting

    # Session
    delete "logout" => "sessions#destroy"
    get "login" => "sessions#new"
    post "login" => "sessions#create"

    # 商品マスタ管理
    resources :products
    resources :categories
    resources :serieses
    resources :solutions

    # 注文管理
    resources :orders, except: [:new, :create]

    # 裏側ユーザ管理
    resources :administrators

    # ページ編集
    resources :pages

    # File Storage
    resources :file_storages

    # 代理店管理
    resources :agencies

    # サロン管理
    resources :salons

    # 情報編集
    resource :information, only: [:show, :edit, :update]

    # 報酬確認画面
    get "reward", to: "reward#show"
  end
end
