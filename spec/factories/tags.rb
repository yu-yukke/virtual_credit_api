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

FactoryBot.define do
  factory :tag do
    name { Faker::Name.unique.name }

    association :author, factory: :user
  end
end
