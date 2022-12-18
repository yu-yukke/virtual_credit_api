# frozen_string_literal: true

class Api::V1::CreatorsController < ApplicationController
  before_action :find_creator, only: %i(show)

  def index
    creators = User.has_works.includes(
      :jobs,
      [works: [:category, :image_files]]
    ).distinct

    render(
      json: creators,
      each_serializer: UserSerializer,
      with_relations: true,
      status: 200
    )
  end

  def show
    render(
      json: @creator,
      serializer: UserSerializer,
      status: 200,
      with_details: true,
      with_relations: true,
    )
  end

  private
    def find_creator
      @creator = User.has_works.includes(
        :jobs,
        [works: [:category, :image_files]]
      ).find params[:id]
    end
end
