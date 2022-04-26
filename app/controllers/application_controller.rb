# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Exceptions
  include ActionController::Cookies
  include ActionController::RequestForgeryProtection

  protect_from_forgery with: :exception

  def set_csrf_token
    cookies["CSRF-TOKEN"] = {
      domain: "http://localhost:3001",
      value: form_authenticity_token
    }
  end
end
