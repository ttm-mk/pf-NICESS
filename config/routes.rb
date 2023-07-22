Rails.application.routes.draw do

  root to: 'public/homes#top'
  get '/about' => 'public/homes#about'

    # ゲストログイン用
  devise_scope :user do
    post 'user/guest_sign_in' => 'public/sessions#guest_sign_in'
  end

  # 管理者用
  devise_for :admins,skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # ユーザー用
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  # admin
  namespace :admin do
    get '/' => 'homes#top'
    resources :users, only: [:show, :edit, :update]
  end

  # user
  scope module: :public do
    get 'user/confirm' => 'users#confirm'
    patch 'user/resign' => 'users#resign'
    resources :users, only: [:show, :edit, :update] do
      # get 'shop/new' => 'shops#new'
      # post '/shop' => 'shops#create'
      resource :shop, only: [:new, :create, :show, :update] do
        resources :items, only: [:new, :create, :index, :show, :edit, :update, :destroy]
      end
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      resources :posts do
        resources :comments, only: [:create, :destroy]
        resource :favorites, only: [:create, :destroy]
      end
    end
    # get 'posts?user_id=:user_id' => 'posts#index'
  end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
