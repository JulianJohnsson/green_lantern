Rails.application.routes.draw do
  resources :transactions
  resources :bridges
  namespace :admin do
      resources :users
      root to: "users#index"
    end
  root to: 'visitors#index'
  devise_for :users
  resources :users

  get '/bankin' => 'bridges#index'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

end
