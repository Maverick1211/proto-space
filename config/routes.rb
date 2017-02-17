Rails.application.routes.draw do
  root to: 'protos#index'
  devise_for :users
  resources :users, only: [:show, :edit, :update]
  resources :protos do
    resources :comments, only: :create
    resources :likes, only: [:create, :destroy]
  end
end
