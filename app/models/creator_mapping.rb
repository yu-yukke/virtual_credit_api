# frozen_string_literal: true

# == Schema Information
#
# Table name: creator_mappings
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  work_id    :bigint           not null
#  is_author  :boolean          default(FALSE), not null
#  deleted_at :datetime
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_creator_mappings_on_deleted_at  (deleted_at)
#  index_creator_mappings_on_user_id     (user_id)
#  index_creator_mappings_on_work_id     (work_id)
#
class CreatorMapping < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  belongs_to :work

  has_many :role_mappings, dependent: :destroy
  has_many :roles, through: :role_mappings
end
