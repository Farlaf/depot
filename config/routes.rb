# frozen_string_literal: true

Rails.application.routes.draw do
  resources :orders
  resources :line_items
  resources :carts
  root 'store#index', as: 'store_index'
  resources :products

  mount LetterOpenerWeb::Engine, at: "/emails" if Rails.env.development?
end
