# frozen_string_literal: true

class CreatorSerializer < ActiveModel::Serializer
  attributes :id, :name, :thumb_image_url
end
