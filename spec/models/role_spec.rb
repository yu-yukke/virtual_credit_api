# frozen_string_literal: true

# == Schema Information
#
# Table name: roles
#
#  id         :bigint           not null, primary key
#  name       :string(191)      not null
#  deleted_at :datetime
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_roles_on_deleted_at  (deleted_at)
#

require "rails_helper"

RSpec.describe Role, type: :model do
  describe "associations" do
    it { should have_many(:role_mappings) }
    it { should have_many(:creator_mappings) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end
end
