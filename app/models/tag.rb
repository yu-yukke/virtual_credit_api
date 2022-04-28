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
class Tag < ApplicationRecord
  acts_as_paranoid

  belongs_to :user

  has_many :tag_mappings, dependent: :destroy
  has_many :works, through: :tag_mappings
end
