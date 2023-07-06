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
  end

  # user
  scope module: :public do
    get 'users/mypage' => 'users#mypage'
    get 'users/mypage/edit' => 'users#edit'
    get 'confirm' => 'users#confirm'
    patch 'resign' => 'users#resign'
    resources :users, only: [:show, :update]
  end
  
  scope module: :public do
    resources :posts, only: [:create]
  end

  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
