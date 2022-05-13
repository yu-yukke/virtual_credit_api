# frozen_string_literal: true

class Api::V1::ReleaseNotesController < ApplicationController
  def index
    release_notes = ReleaseNote.all

    render json: release_notes, each_serializer: ReleaseNoteSerializer, status: 200
  end

  def create
    release_note = ReleaseNote.new release_note_params

    if release_note.save
      render json: release_note, serializer: ReleaseNoteSerializer, status: 201
    else
      render json: { errors: release_note.errors.full_messages }, status: 422
    end
  end

  private
    def release_note_params
      params.permit(
        :version,
        :subject,
        :description,
        :released_at
      )
    end
end
