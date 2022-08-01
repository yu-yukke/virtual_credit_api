# frozen_string_literal: true

# == Schema Information
#
# Table name: link_in_bios
#
#  id         :bigint           not null, primary key
#  work_id    :bigint           not null
#  name       :string(255)      not null
#  url        :string(255)      not null
#  deleted_at :datetime
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_link_in_bios_on_deleted_at  (deleted_at)
#  index_link_in_bios_on_work_id     (work_id)
#
require "rails_helper"

RSpec.describe LinkInBio, type: :model do
  describe "associations" do
    it { should belong_to(:work) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:url) }
  end
end
