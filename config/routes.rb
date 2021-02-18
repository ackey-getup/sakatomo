Rails.application.routes.draw do
  devise_for :users
  root to: 'plays#index'
  resources :plays
  resources :playzones, only: [:index, :show]
  resources :users, only: :show
end
