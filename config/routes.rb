Rails.application.routes.draw do
  root to: 'protos#index'
  devise_for :users
  resources :users, only: [:show, :edit, :update]
  scope module: :protos do
    resources :popular, only: :index
  end
  resources :protos do
    resources :comments, only: :create
    resources :likes, only: [:create, :destroy]
  end
  resources :tags, only: [:index, :show]
end
