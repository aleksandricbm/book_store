Rails.application.routes.draw do
  root 'home#home'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources 'book'
  get 'catalog', to: 'catalog#show'
  get '/catalog/:id', to: 'catalog#show', as: 'catalog_id'
  resources 'category', only: [:show]
end
