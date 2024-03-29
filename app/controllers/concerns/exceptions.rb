# frozen_string_literal: true

module Exceptions
  extend ActiveSupport::Concern

  included do
    class Forbidden < ActionController::ActionControllerError; end
    class IpAddressRejected < ActionController::ActionControllerError; end

    rescue_from Exception, with: :rescue500
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from Forbidden, with: :rescue403
    rescue_from IpAddressRejected, with: :rescue403
    rescue_from ActionController::RoutingError, with: :rescue404

    def rescue500(e)
      render json: { error: "予期せぬエラーが発生しました。" }, status: 500

      Rails.logger.error e
    end

    def rescue403(e)
      render json: { error: "指定のページへはアクセスできません。" }, status: 403

      Rails.logger.error e
    end

    def not_found(e)
      render json: { error: "対象のレコードが存在しません。" }, status: 404

      Rails.logger.error e
    end

    def rescue404(e)
      render json: { error: "ページが存在しません。" }, status: 404

      Rails.logger.error e
    end
  end
end
