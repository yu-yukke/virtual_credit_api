# frozen_string_literal: true

# == Schema Information
#
# Table name: jobs
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
#  index_jobs_on_deleted_at  (deleted_at)
#
class Job < ApplicationRecord
  acts_as_paranoid
  has_ancestry orphan_strategy: :restrict

  has_many :job_mappings, dependent: :destroy
  has_many :users, through: :job_mappings

  validates :name, presence: true, uniqueness: true

  validate :check_parent_exists

  private
    def check_parent_exists
      return unless self.ancestry

      errors.add(:base, "ancestryの値が不正です") unless parent
    end
end
