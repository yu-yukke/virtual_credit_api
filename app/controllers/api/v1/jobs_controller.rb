# frozen_string_literal: true

class Api::V1::JobsController < ApplicationController
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

  private
    def job_params
      params.require(:job).permit(
        :name,
        :ancestry
      )
    end
end
