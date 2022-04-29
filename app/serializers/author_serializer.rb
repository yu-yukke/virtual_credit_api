# frozen_string_literal: true

class AuthorSerializer < ActiveModel::Serializer
  attributes :id, :name, :thumb_image_url
end
