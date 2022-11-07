# frozen_string_literal: true

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # TODO: 環境ごとのアドレス設定
    origins "http://127.0.0.1:3000"

    resource "*",
    headers: :any,
    expose: ["access-token", "expiry", "token-type", "uid", "client", "X-CSRF-Token"],
    methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
