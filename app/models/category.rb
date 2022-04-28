# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string(191)      not null
#  ancestry   :string(191)
#  deleted_at :datetime
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_categories_on_deleted_at  (deleted_at)
#
class Category < ApplicationRecord
  acts_as_paranoid
  has_ancestry orphan_strategy: :restrict

  has_many :works

  validates :name, presence: true, uniqueness: true

  validate :check_parent_exists

  private
    def check_parent_exists
      return unless self.ancestry

      errors.add(:base, "ancestryの値が不正です") unless parent
    end
end
