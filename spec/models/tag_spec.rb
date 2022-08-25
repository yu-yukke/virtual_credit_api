# frozen_string_literal: true

# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  name       :string(191)      not null
#  deleted_at :datetime
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_tags_on_deleted_at  (deleted_at)
#  index_tags_on_user_id     (user_id)
#
require "rails_helper"

RSpec.describe Tag, type: :model do
  describe "associations" do
    it { should belong_to(:author) }

    it { should have_many(:tag_mappings) }
    it { should have_many(:works) }
  end
end
