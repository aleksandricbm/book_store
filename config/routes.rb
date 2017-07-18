Rails.application.routes.draw do
  get 'users/profile'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'home#home'
end
