# frozen_string_literal: true

# == Schema Information
#
# Table name: videos
#
#  id         :bigint           not null, primary key
#  work_id    :bigint           not null
#  video_url  :string(255)
#  deleted_at :datetime
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_videos_on_deleted_at  (deleted_at)
#  index_videos_on_work_id     (work_id)
#

FactoryBot.define do
  factory :video do
    video_url { Faker::Internet.url }

    association :work
  end
end
