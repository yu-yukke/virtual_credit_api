# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      devise_scope :user_authentication do
        get "sign_in", to: "devise/sessions#new", as: :new_user_session
        get "sign_out", to: "devise/sessions#destroy", as: :destroy_user_session
      end

      mount_devise_token_auth_for "UserAuthentication", at: "auth", controllers: {
        omniauth_callbacks: "api/v1/auth/omniauth_callbacks"
      }

      # ジョブ
      resources :jobs

      # カテゴリ
      resources :categories

      # 作品
      resources :works do
        resources :related_category_works, only: %i(index), module: :works
        resources :creators_other_works, only: %i(index), module: :works
      end

      # リリースノート
      resources :release_notes
    end
  end
end
