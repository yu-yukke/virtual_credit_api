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
FactoryBot.define do
  factory :creator_mapping do
    is_author { false }

    association :user
    association :work

    trait :author do
      is_author { true }
    end
  end
end
