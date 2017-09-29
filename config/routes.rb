Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'home#home'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }

  resources :books, only: %i[show index]
  get 'catalog', to: 'books#index'
  resource :cart, only: %i[show update]
  resources :order_items, only: %i[create destroy] do
    put 'decrease', on: :member
    put 'increase', on: :member
  end

  resource :orders, only: %i[index show]
  resources :checkout_steps, only: %i[show update]
  resources :reviews, only: :create
  resources :images, only: %i[new create show]
  match 'settings/address', to: 'settings#index', via: 'get'
  match 'settings/address', to: 'settings#create', via: 'post'

  match 'settings/privacy', to: 'users#index', via: 'get'
  match 'settings/privacy', to: 'users#update', via: 'patch'
end
