Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: 'plays#index'
  resources :plays do
    resources :comments, only: [:create]
  end
  resources :playzones, only: [:index]
  resources :users, only: [:show]
  get 'help', to: 'plays#help'
end
