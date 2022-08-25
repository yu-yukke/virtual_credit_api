# frozen_string_literal: true

class Api::V1::TagsController < ApplicationController
  def index
    tags = Tag.all

    render(
      json: tags,
      each_serializer: TagSerializer,
      status: 200
    )
  end
end
