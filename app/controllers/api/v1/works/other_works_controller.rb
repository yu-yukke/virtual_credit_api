# frozen_string_literal: true

class Api::V1::Works::OtherWorksController < ApplicationController
  def index
    work = Work.find_by id: params[:work_id]
    other_works = work.creators.includes(:jobs).map do |creator|
      creator.works.includes(
        :category, :author, :image_files, { creators: :jobs }, { tags: :author }, { assets: :author }
      )
    end.flatten.uniq
    other_works.delete(work)

    render(
      json: other_works.sort { |work| work.favorites.count }.first(15),
      each_serializer: WorkSerializer,
      status: 200
    )
  end
end
