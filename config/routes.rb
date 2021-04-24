Rails.application.routes.draw do

  devise_for :users
  root to: 'home#top'
  get 'home/about'
  resources :users, only: [:index, :show, :create, :edit, :update]
  resources :books, only: [:edit, :update, :new, :create, :index, :show, :destroy]
end