# frozen_string_literal: true

# == Schema Information
#
# Table name: works
#
#  id             :bigint           not null, primary key
#  category_id    :bigint           not null
#  name           :string(191)      not null
#  description    :text(65535)      not null
#  main_image_url :string(255)      not null
#  deleted_at     :datetime
#  created_at     :datetime
#  updated_at     :datetime
#
# Indexes
#
#  index_works_on_category_id  (category_id)
#  index_works_on_deleted_at   (deleted_at)
#
require "rails_helper"

RSpec.describe Video, type: :model do
  describe "associations" do
    it { should belong_to(:work) }
  end

  describe "validations" do
    it { should validate_presence_of(:video_url) }
  end
end
