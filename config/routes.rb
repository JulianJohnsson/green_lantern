Rails.application.routes.draw do
  resources :categories
  resources :transactions
  resources :bridges
  resources :comments
  resources :preferences
  resources :subscriptions
  resources :projects
  namespace :admin do
      resources :users
      root to: "users#index"
    end
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
  resources :users

  authenticated :user do
    root 'bridges#index', as: :authenticated_root
  end

  get 'track_trump' => 'users#track_trump'

  get '/bankin' => 'bridges#index'
  get '/account' => 'bridges#account'
  get '/waitlist' => 'users#waitlist'
  get '/dashboard' => 'transactions#dashboard'
  get '/categorize' => 'transactions#categorize'
  get '/track' => 'categories#track'
  get '/compare' => 'categories#compare'
  get '/faq' => 'high_voltage/pages#show', id: 'faq'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

end
