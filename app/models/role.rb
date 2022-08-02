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
class Role < ApplicationRecord
  acts_as_paranoid

  has_many :creator_mappings

  validates :name, presence: true, uniqueness: true
end
