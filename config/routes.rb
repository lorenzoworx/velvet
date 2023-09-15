Rails.application.routes.draw do
  devise_for :users
  root 'users#index'
  resources :users, only: [:show, :edit, :update] do
    resources :posts, only: [:index, :show]
  end

  resources :posts, only: [:new, :create] do
    resources :comments, only: [:new, :create]
    resources :likes, only: [:create]
  end
end
