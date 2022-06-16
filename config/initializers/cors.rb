# frozen_string_literal: true

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # TODO: 環境ごとのアドレス設定
    origins "*"

    resource "*",
    headers: :any,
    expose: ["access-token", "expiry", "token-type", "uid", "client"],
    methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
