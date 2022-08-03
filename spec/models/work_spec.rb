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

RSpec.describe Work, type: :model do
  describe "associations" do
    it { should belong_to(:category) }

    it { should have_one(:author_mapping) }
    it { should have_one(:author) }
    it { should have_one(:video) }

    it { should have_many(:image_files) }
    it { should have_many(:favorites) }
    it { should have_many(:favorite_users) }
    it { should have_many(:creator_mappings) }
    it { should have_many(:creators) }
    it { should have_many(:tag_mappings) }
    it { should have_many(:tags) }
    it { should have_many(:asset_mappings) }
    it { should have_many(:assets) }
    it { should have_many(:link_in_bios) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:main_image_url) }
  end
end
