# frozen_string_literal: true

class Api::V1::WorksController < ApplicationController
  before_action :find_work, only: %i(show)

  def index
    works = Work.all.includes(:category)

    render(
      json: works,
      each_serializer: WorkSerializer,
      status: 200
    )
  end

  def show
    render(
      json: @work,
      serializer: WorkSerializer,
      status: 200,
      with_details: true
    )
  end

  private
    def find_work
      @work = Work.includes(
        :category, :image_files, :link_in_bios, :creators,
        :tags, [assets: :author]
      ).find params[:id]
    end
end
