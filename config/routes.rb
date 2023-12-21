# frozen_string_literal: true

Rails.application.routes.draw do
  get 'admin'=> 'admin#index'
  controller :sessions do
    get 'login'=> :new
    post 'login'=> :create
    delete 'logout'=> :destroy
  end

  get 'admin/index'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  resources :users
  resources :orders
  resources :line_items
  resources :carts
  root 'store#index', as: 'store_index'
  resources :products

  mount LetterOpenerWeb::Engine, at: "/emails" if Rails.env.development?
end
