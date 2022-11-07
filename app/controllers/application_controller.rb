# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Exceptions
  include ActionController::Cookies
  include ActionController::RequestForgeryProtection

  protect_from_forgery with: :exception

  before_action :skip_session
  skip_before_action :verify_authenticity_token, if: :devise_controller?

  def set_csrf_token
    response.set_header(
      'X-CSRF-Token',
      form_authenticity_token
    )
  end

  protected
    def skip_session
      request.session_options[:skip] = true
    end
end
