# frozen_string_literal: true

class Api::V1::UserAuthenticationsController < ApplicationController
  after_action :set_csrf_token

  def index
    if current_api_v1_user_authentication
      render(
        json: current_api_v1_user_authentication.user,
        serializer: UserSerializer,
        status: 200
      )
    else
      render(
        json: {},
        status: 200
      )
    end
  end
end
