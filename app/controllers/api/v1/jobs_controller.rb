# frozen_string_literal: true

class Api::V1::JobsController < ApplicationController
  before_action :find_job, only: %i(update destroy)

  def index
    jobs = Job.all

    render json: jobs, each_serializer: JobSerializer
  end

  def create
    job = Job.new job_params

    if job.save
      render json: job, serializer: JobSerializer, status: 201
    else
      render json: { errors: job.errors.full_messages }, status: 422
    end
  end

  def update
    if @job.update update_job_params
      render json: {}, status: 204
    else
      render json: { errors: @job.errors.full_messages }, status: 422
    end
  end

  def destroy
    if @job.destroy
      render json: {}, status: 204
    else
      render json: { errors: @job.errors.full_messages }, status: 422
    end
  rescue => e
    render json: { error: "子を持つ親カテゴリーは削除できません。" }, status: 400

    Rails.logger.error e
  end

  private
    def find_job
      @job = Job.find params[:id]
    end

    def job_params
      params.require(:job).permit(
        :name,
        :ancestry
      )
    end

    def update_job_params
      params.require(:job).permit(
        :name
      )
    end
end
