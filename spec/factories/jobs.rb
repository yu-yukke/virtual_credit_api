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
FactoryBot.define do
  factory :job do
    name { Faker::Job.unique.title }
    ancestry { nil }
  end
end
