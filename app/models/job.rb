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

  has_many :job_mappings, dependent: :destroy
  has_many :users, through: :job_mappings
end
