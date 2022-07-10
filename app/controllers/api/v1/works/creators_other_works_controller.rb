# frozen_string_literal: true

class Api::V1::Works::CreatorsOtherWorksController < ApplicationController
  def index
    work = Work.find_by id: params[:work_id]
    other_works = work.creators.map do |creator|
      creator.works.includes(
        :category, :author, :image_files, { creators: :jobs }, { tags: :author }, { assets: :author }
      ).where.not(id: work.id)
    end
    .flatten
    .uniq
    .sort_by { |work| work.favorites.count }
    .take(5)
    # TODO: とりあえず5件にしてるけど増やす

    if other_works.empty?
      render json: [], status: 200
    else
      render json: other_works, each_serializer: WorkSerializer, status: 200
    end
  end
end
