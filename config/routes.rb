Rails.application.routes.draw do
  resources :categories
  resources :transactions
  resources :bridges
  resources :comments
  resources :subscriptions
  resources :projects
  resources :matches
  resources :scores
  namespace :admin do
      resources :users
      root to: "users#index"
    end
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
  resources :users

  authenticated :user do
    root 'dashboards#index', as: :authenticated_root
  end

  devise_scope :user do
    root to: "users/sessions#new"
  end

  get '/bankin' => 'bridges#index'
  get '/account' => 'bridges#account'
  get '/later' => 'bridges#later'
  get '/waitlist' => 'users#waitlist'

  get '/dashboard' => 'dashboards#index'
  get '/categorize' => 'transactions#categorize'

  get '/track' => 'categories#track'
  get '/compare_with' => 'matches#index'
  get '/reduce' => 'reductions#index'
  get '/compare', to: redirect('/reduce', status: 301)

  get '/faq' => 'high_voltage/pages#show', id: 'faq'

  get '/onboarding' => 'scores#onboarding'

  get '/scores/:id/edit_transport' => 'scores#edit_transport'
  get '/scores/:id/edit_plane' => 'scores#edit_plane'
  get '/scores/:id/edit_plane2' => 'scores#edit_plane2'
  get '/scores/:id/edit_house' => 'scores#edit_house'
  get '/scores/:id/edit_regime' => 'scores#edit_regime'

  get '/subscriptions/show' => 'subscriptions#show'
  delete '/subscriptions' => 'subscriptions#destroy'

  require 'sidekiq/web'
  require 'sidekiq-scheduler/web'
  mount Sidekiq::Web => '/sidekiq'

  resources :gifts
  get '/gifts/:id/choose_formula' => 'gifts#choose_formula'
  get '/gifts/:id/checkout' => 'gifts#checkout'
  post 'gifts/:id/submit' => 'gifts#submit'

  resources :reductions

  post '/sendkeys' => 'notifications#sendPush'

  resources :transaction_modifiers
  get '/badges' => 'badges#index'

end
