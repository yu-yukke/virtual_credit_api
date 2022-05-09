# frozen_string_literal: true

# == Schema Information
#
# Table name: favorites
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  work_id    :bigint           not null
#  deleted_at :datetime
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_favorites_on_deleted_at  (deleted_at)
#  index_favorites_on_user_id     (user_id)
#  index_favorites_on_work_id     (work_id)
#
FactoryBot.define do
  factory :favorite do
    association :user
    association :work
  end
end
