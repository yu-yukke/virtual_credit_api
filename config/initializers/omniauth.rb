# frozen_string_literal: true

# 開発用にGET許可
OmniAuth.config.allowed_request_methods = [:post, :get]
OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter,
  Rails.application.credentials.authentication[:twitter_key],
  Rails.application.credentials.authentication[:twitter_key_secret],
  callback_url: "http://127.0.0.1:4000/api/v1/auth/twitter/callback"
end
