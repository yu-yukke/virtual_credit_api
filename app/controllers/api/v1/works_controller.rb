# frozen_string_literal: true

class Api::V1::WorksController < ApplicationController
  def index
    works = Work.all.includes(
      :category, :image_files, :creators, [tags: :author], [assets: :author]
    )

    render json: works, each_serializer: WorkSerializer, status: 200
  end
end
