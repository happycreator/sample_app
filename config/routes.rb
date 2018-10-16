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
  resources :attendances # attendances/month_edit, attendances/month_update のようなルーティングを作成(入れ子のルーティングの書き方を調査)
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :relationships,       only: [:create, :destroy]
end