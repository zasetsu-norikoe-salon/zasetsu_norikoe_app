# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'users#index'
  devise_for :users
  resources :users, only: [:index, :show]
  namespace :mock do
    get 'users/login'
    get 'users/index'
    get 'users/show'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
