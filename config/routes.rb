Rails.application.routes.draw do
  root 'home#home'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources 'book'
  get 'catalog', to: 'catalog#show'
  get '/catalog/:id', to: 'catalog#show', as: 'catalog_id'
  resources 'category', only: [:show]
  resource :cart, only: %i[show update]
  resources :order_items, only: [:create, :destroy] do
    put 'decrease', on: :member
    put 'increase', on: :member
  end
  resource :setting, only: %i[show update] do
    put :change_email
    put :change_pwd
  end
  get 'my_orders', to: 'settings#orders'
  get 'my_orders/:id', to: 'settings#order_details', as: 'order_details'
  resources :checkout_steps, only: %i[index show update]
  resources :reviews, only: :create
end
