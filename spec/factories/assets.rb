# frozen_string_literal: true

# == Schema Information
#
# Table name: assets
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  name       :string(191)      not null
#  url        :string(255)      not null
#  image_url  :string(255)      not null
#  deleted_at :datetime
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_assets_on_deleted_at  (deleted_at)
#  index_assets_on_user_id     (user_id)
#

FactoryBot.define do
  factory :asset do
    name { Faker::Name.unique.name }
    url { Faker::Internet.url }
    image_url { Faker::Internet.url }

    association :author, factory: :user
  end
end
