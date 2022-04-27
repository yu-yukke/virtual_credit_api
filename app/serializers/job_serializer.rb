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
class JobSerializer < ApplicationSerializer
  attributes :id, :name, :ancestry, :number_of_users

  def number_of_users
    object.users.count
  end
end
