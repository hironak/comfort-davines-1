Commers::Application.routes.draw do

  get "sitemap/index"
  get "f/:filename", to: "file_storage#show"
  get "template/stylesheets/:key", to: "template#stylesheets"
  get "editable/stylesheets/:key", to: "editable#stylesheets"

  # メルマガユーザーエクスポート
  resources :mailmagazine_export, only: [:index]

  namespace :landing, path: 'land' do
    get :oioil, action: :oioil
  end

  # 表側ユーザ
  devise_scope :consumer do
    get "complete", to: "consumers/registrations#complete"
  end
  devise_for :consumers,
    path: 'mypage',
    controllers: {
      sessions: "sessions",
      registrations: "consumers/registrations",
      confirmations: "consumers/confirmations"
    }

  # トップページ
  controller :welcome do
    root action: "index"
    get "introduction", action: "introduction"
    get "about", action: "about"
    get "utilization", action: "utilization"
    get "faq", action: "faq"
    get "sitemap", action: "sitemap"
    get "company", action: "company"
    get "tradeinfo", action: "tradeinfo"
    get "privacypolicy", action: "privacypolicy"
    get "shops", action: "shops"
  end

  namespace :mypage do
    root action: :information
    patch "information", action: :update_information
  end

  # お問い合わせ
  controller :contact do
    get "contact", action: :new
    post "contact", action: :create
  end

  # 注文履歴
  resources :orders, only: [:index, :show, :edit, :update]

  # News
  resources :topics, only: [:index, :show]

  # プレスリリース
  resources :press_releases, only: [:index]

  # News
  resources :news_releases, only: [:index, :show]

  # 詳細ページ
  resources :products, only: [:index, :show] do
    collection do
      get 'newitems'
      get 'ranking'
    end
  end

  # 商品一覧
  namespace :catalog do
    get ":action/:id"
  end

  # レビュー
  resources :reviews, only: [:create]

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

    get "sample"
    patch "sample", action: "sample_create"

    get "shipment"
    patch "shipment", action: "shipment_create"

    get "payment"
    patch "payment", action: "payment_create"

    get "confirm"
    patch "confirm", action: "confirm_create"

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

    # プレスリリース
    resources :press_releases

    # Topics
    resources :topics

    # News
    resources :news_releases

    # 商品マスタ管理
    resources :products
    resources :categories
    resources :serieses
    resources :solutions

    # お客様の声
    resources :reviews, only: [:index, :show, :edit, :update, :destroy]

    # 注文管理
    resources :orders, except: [:new, :create] do
      collection do
        post :update_status
      end
    end

    # 売上一覧
    resources :sales, only: [:index] do
      collection do
        get :products
      end
    end

    # 裏側ユーザ管理
    resources :administrators

    resources :consumers

    # デザインテンプレート編集
    resources :templates

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
