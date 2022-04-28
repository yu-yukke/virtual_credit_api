# frozen_string_literal: true

class Api::V1::CategoriesController < ApplicationController
  def index
    categories = Category.all

    render json: categories, each_serializer: CategorySerializer
  end
end
