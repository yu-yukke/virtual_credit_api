# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      # ジョブ
      resources :jobs

      # カテゴリ
      resources :categories

      # 作品
      resources :works

      # リリースノート
      resources :release_notes
    end
  end
end
