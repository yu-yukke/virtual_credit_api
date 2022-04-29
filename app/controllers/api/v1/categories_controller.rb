# frozen_string_literal: true

class Api::V1::CategoriesController < ApplicationController
  before_action :find_category, only: %i(show update destroy)

  def index
    categories = Category.all

    render json: categories, each_serializer: CategorySerializer, status: 200
  end

  def show
    render json: @category, serializer: CategorySerializer, status: 200
  end

  def create
    category = Category.new category_params

    if category.save
      render json: category, serializer: CategorySerializer, status: 201
    else
      render json: { errors: category.errors.full_messages }, status: 422
    end
  end

  def update
    if @category.update update_category_params
      render json: {}, status: 204
    else
      render json: { errors: @category.errors.full_messages }, status: 422
    end
  end

  def destroy
    if @category.destroy
      render json: {}, status: 204
    else
      render json: { errors: @category.errors.full_messages }, status: 422
    end
  rescue => e
    render json: { error: "子を持つ親カテゴリーは削除できません。" }, status: 400

    Rails.logger.error e
  end

  private
    def find_category
      @category = Category.find params[:id]
    end

    def category_params
      params.require(:category).permit(
        :name,
        :ancestry
      )
    end

    def update_category_params
      params.require(:category).permit(
        :name
      )
    end
end
