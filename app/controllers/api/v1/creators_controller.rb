# frozen_string_literal: true

class Api::V1::CreatorsController < ApplicationController
  def index
    creators = User.all.includes(:jobs, [works: [:category, :image_files]])

    render(
      json: creators,
      each_serializer: UserSerializer,
      with_relations: true,
      status: 200
    )
  end
end
