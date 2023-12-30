Rails.application.routes.draw do
  root 'pages#home'
  get 'about', to: 'pages#about'
  get 'articlestable', to: 'pages#articlestable'
  resources :articles
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
