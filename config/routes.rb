Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: 'plays#index'
  resources :plays do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end
  resources :users, only: [:show]
  get 'help', to: 'plays#help'
  get 'list', to: "plays#list"
end