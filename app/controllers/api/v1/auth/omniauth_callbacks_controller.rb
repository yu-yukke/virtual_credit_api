# frozen_string_literal: true

class Api::V1::Auth::OmniauthCallbacksController < DeviseTokenAuth::OmniauthCallbacksController
  skip_before_action :skip_session

  def omniauth_success
    callback_from params[:provider]
    super
  end

  def omniauth_failure
    super
  end

  def redirect_callbacks
    super
  end

  private
    def callback_from(provider)
      @user_authentication = UserAuthentication.find_for_oauth(auth_hash)

      if @user_authentication.persisted?
        sign_in_and_redirect @user_authentication, event: :authentication
      else
        session["devise.#{provider}_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_path, alert: @user
      end
    end
end
