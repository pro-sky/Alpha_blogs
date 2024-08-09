require 'sidekiq/web'


Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  root 'pages#home'
  get 'about', to: 'pages#about'
  get 'articlestable', to: 'pages#articlestable'
  get 'external_articles', to: 'articles#external'
  resources :articles do
    resources :reactions, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    member do
      get 'download'
    end
  end
  resources :comments do
    resources :reactions, only: [:create, :destroy]
  end
  get 'signup', to: 'users#new'
  get 'userlist', to: 'users#userlist'
  resources :users, except: [:new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :categories, except: [:destroy]
  get 'password/reset', to: 'password_resets#new'
  post 'password/reset', to: 'password_resets#create'
  resources :password_resets, only: [:edit, :update]
  get '/password_resets/:id/edit', to: 'password_resets#edit'
  put '/password_resets/:id', to: 'password_resets#update', as: "update/password"
  resources :users do
    resources :direct_messages, only: [:index, :new, :create]
  end
  get 'chats', to: 'direct_messages#chats', as: 'chats'
  post 'send_email', to: 'emails#send_email'

end
