# frozen_string_literal: true

class Api::V1::Works::CreatorsOtherWorksController < ApplicationController
  def index
    work = Work.find_by id: params[:work_id]
    other_works = work.creators.map do |creator|
      creator.works.includes(:category).where.not(id: work.id)
    end
    .flatten
    .uniq
    .sort_by { |work| work.favorites.count }
    .take(4)
    # TODO: とりあえず4件にしてるけど増やす

    if other_works.empty?
      render json: [], status: 200
    else
      render json: other_works, each_serializer: WorkSerializer, status: 200
    end
  end
end
