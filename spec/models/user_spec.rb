# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  name            :string(191)      not null
#  description     :text(65535)
#  main_image_url  :string(255)
#  thumb_image_url :string(255)
#  deleted_at      :datetime
#  created_at      :datetime
#  updated_at      :datetime
#
# Indexes
#
#  index_users_on_deleted_at  (deleted_at)
#
require "rails_helper"

RSpec.describe User, type: :model do
  describe "associations" do
    it { should have_one(:user_authentication) }
    it { should have_one(:social) }

    it { should have_many(:favorites) }
    it { should have_many(:favorite_works) }
    it { should have_many(:job_mappings) }
    it { should have_many(:jobs) }
    it { should have_many(:creator_mappings) }
    it { should have_many(:works) }
    it { should have_many(:tags) }
    it { should have_many(:assets) }
    it { should have_many(:inquiries) }
  end
end
