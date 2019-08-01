Rails.application.routes.draw do
  resources :categories
  resources :transactions
  resources :bridges
  namespace :admin do
      resources :users
      root to: "users#index"
    end
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users

  authenticated :user do
    root 'bridges#index', as: :authenticated_root
  end

  root to: 'visitors#index'

  get '/bankin' => 'bridges#index'
  get '/account' => 'bridges#account'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

end
