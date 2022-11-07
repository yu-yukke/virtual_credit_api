# frozen_string_literal: true

OmniAuth.config.allowed_request_methods = [:get, :post]
OmniAuth.config.silence_get_warning = true
OmniAuth.config.logger = Rails.logger if Rails.env.development?

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter,
  Rails.application.credentials.authentication[:twitter_key],
  Rails.application.credentials.authentication[:twitter_key_secret],
  callback_url: "http://127.0.0.1:4000/api/v1/auth/twitter/callback"
end
