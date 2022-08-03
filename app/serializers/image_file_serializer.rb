# frozen_string_literal: true

# == Schema Information
#
# Table name: image_files
#
#  id         :bigint           not null, primary key
#  work_id    :bigint           not null
#  sequence   :integer          not null
#  image_url  :string(255)
#  deleted_at :datetime
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_image_files_on_deleted_at  (deleted_at)
#  index_image_files_on_work_id     (work_id)
#
class ImageFileSerializer < ApplicationSerializer
  attributes :id, :sequence, :file_type, :image_url, :video_url
end
