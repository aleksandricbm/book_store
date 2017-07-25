Rails.application.routes.draw do
  get 'users/profile'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources 'book'
  get 'catalog', to: 'catalog#show'
  get '/catalog/:id', to: 'catalog#show', as: 'catalog_id'
  resources 'category', only: [:show]
  root 'home#home'
end
