# frozen_string_literal: true

# == Schema Information
#
# Table name: videos
#
#  id         :bigint           not null, primary key
#  work_id    :bigint           not null
#  embed_code :text(65535)
#  deleted_at :datetime
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_videos_on_deleted_at  (deleted_at)
#  index_videos_on_work_id     (work_id)
#
class Video < ApplicationRecord
  acts_as_paranoid

  belongs_to :work

  validates :embed_code, presence: true
end
