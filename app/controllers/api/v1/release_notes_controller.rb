# frozen_string_literal: true

class Api::V1::ReleaseNotesController < ApplicationController
  def index
    release_notes = ReleaseNote.all

    render json: release_notes, each_serializer: ReleaseNoteSerializer, status: 200
  end
end
