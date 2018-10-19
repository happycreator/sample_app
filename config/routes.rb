Rails.application.routes.draw do
  devise_for :admin_users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

  root   'static_pages#home'
  get    '/about',   to: 'static_pages#about'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  resources :users do
    member do
    end
  end
  resources :account_activations, only: [:edit]
  #ルーティングを作成(入れ子のルーティングの書き方を調査)
  resources :attendances do
    collection do
      get '/month_edit',   to: 'attendances#month_edit'
      post '/month_update',   to: 'attendances#month_update'
    end
  end
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :relationships,       only: [:create, :destroy]
end