# frozen_string_literal: true

class Api::V1::JobsController < ApplicationController
  def index
    response = Job.all
    render json: response, each_serializer: JobSerializer
  end
end
