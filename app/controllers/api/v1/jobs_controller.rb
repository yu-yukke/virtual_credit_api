# frozen_string_literal: true

class Api::V1::JobsController < ApplicationController
  def index
    jobs = Job.all
    render status: 200, json: { items: jobs }
  end
end
