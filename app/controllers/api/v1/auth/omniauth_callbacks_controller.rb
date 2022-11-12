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
      UserAuthentication.find_or_create_for_oauth(auth_hash)
    end

  protected
    def handle_new_resource
      @oauth_registration = true
      # don't set password
    end
end
