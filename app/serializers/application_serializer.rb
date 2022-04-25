# frozen_string_literal: true

class ApplicationSerializer < ActiveModel::Serializer
  attributes :created_at, :updated_at, :deleted_at
end
