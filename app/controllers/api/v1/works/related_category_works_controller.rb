# frozen_string_literal: true

class Api::V1::Works::RelatedCategoryWorksController < ApplicationController
  def index
    work = Work.find_by id: params[:work_id]
    category = work.category
    related_works = category.works.includes(:image_files, :author, :link_in_bios,
      [creators: :jobs], [tags: :author], [assets: :author]
    ).where.not(id: work.id)
    .sort_by { |work| work.favorites.count }
    .uniq
    .take(4)
    # TODO: とりあえず4件にしてるけど増やす

    if related_works.empty?
      render json: [], status: 200
    else
      render json: related_works, each_serializer: WorkSerializer, status: 200
    end
  end
end
