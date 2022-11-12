# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      mount_devise_token_auth_for "UserAuthentication", at: "auth", controllers: {
        omniauth_callbacks: "api/v1/auth/omniauth_callbacks"
      }

      # ジョブ
      resources :jobs

      # カテゴリ
      resources :categories

      # クリエイター
      resources :creators

      # 作品
      resources :works do
        resources :related_category_works, only: %i(index), module: :works
        resources :creators_other_works, only: %i(index), module: :works
      end

      # リリースノート
      resources :release_notes

      # タグ
      resources :tags, only: %i(index)

      # 認証
      resources :users, only: %i() do
        collection do
          get :me, to: "user_authentications#index"
        end
      end
    end
  end
end
