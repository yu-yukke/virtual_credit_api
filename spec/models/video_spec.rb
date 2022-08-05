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
require "rails_helper"

RSpec.describe Video, type: :model do
  describe "associations" do
    it { should belong_to(:work) }
  end

  describe "validations" do
    it { should validate_presence_of(:embed_code) }
  end
end
