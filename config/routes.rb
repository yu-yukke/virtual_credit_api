# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users
      resources :products
      resources :release_notes
      resources :admin_users
      resources :notifications
      resources :jobs
      resources :categories
    end
  end
end
