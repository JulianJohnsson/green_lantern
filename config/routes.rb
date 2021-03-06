Rails.application.routes.draw do
  resources :categories
  resources :transactions
  resources :bridges
  get '/connexion' => 'bridges#connexion'
  resources :comments
  post '/feedback' => 'comments#feedback'
  get 'subscriptions/project' => 'subscriptions#project'
  get 'subscriptions/formula' => 'subscriptions#formula'
  get 'subscriptions/payment' => 'subscriptions#payment'
  resources :subscriptions
  resources :projects
  resources :matches
  get '/scores/edit' => 'scores#edit'
  resources :scores
  namespace :admin do
      resources :users
      root to: "users#index"
    end
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
  devise_scope :user do
    get '/connexion-la-banque-postale' => 'users/registrations#new'
  end
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
  get '/next' => 'bridges#next'

  get '/dashboard' => 'dashboards#index'
  get '/categorize' => 'transactions#categorize'

  get '/track' => 'categories#track'
  get '/compare_with' => 'matches#index'
  get '/trends' => 'matches#trends'
  get '/indice-carbone' => 'visitors#index'
  get '/api' => "visitors#api"
  get '/reduce' => 'reductions#index'
  get '/compare', to: redirect('/reduce', status: 301)

  get '/faq' => 'high_voltage/pages#show', id: 'faq'

  get '/onboarding' => 'scores#onboarding'

  get '/scores/:id/edit_transport' => 'scores#edit_transport'
  get '/scores/:id/edit_plane' => 'scores#edit_plane'
  get '/scores/:id/edit_plane2' => 'scores#edit_plane2'
  get '/scores/:id/edit_house' => 'scores#edit_house'
  get '/scores/:id/edit_regime' => 'scores#edit_regime'
  get '/scores/:id/edit_house2' => 'scores#edit_house2'

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
  get '/badges/calcul' => 'badges#calcul'
  post '/badges/add' => 'badges#add'

  resources :accounts

  mount Split::Dashboard, at: 'split'

  get '/:id' => "shortener/shortened_urls#show"
end
