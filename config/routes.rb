Rails.application.routes.draw do

  root to: 'homes#top'

  devise_for :users

  get 'about' => 'homes#about' , as: 'about'
  resources :books, only: [:create, :index, :show, :edit, :destroy]
  resources :users, only: [:show, :index, :edit, :create]



end
