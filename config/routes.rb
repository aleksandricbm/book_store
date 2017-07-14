Rails.application.routes.draw do
  get 'users/profile'

  devise_for :users
  root 'home#home'
end
