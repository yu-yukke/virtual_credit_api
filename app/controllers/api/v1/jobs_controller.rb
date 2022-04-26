# frozen_string_literal: true

class Api::V1::JobsController < ApplicationController
  def index
    jobs = Job.all
    render json: jobs, each_serializer: JobSerializer
  end
end
