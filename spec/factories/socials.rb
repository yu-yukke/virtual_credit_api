# frozen_string_literal: true

# == Schema Information
#
# Table name: socials
#
#  id            :bigint           not null, primary key
#  user_id       :bigint           not null
#  twitter_id    :string(191)
#  youtube_url   :string(191)
#  instagram_url :string(191)
#  facebook_url  :string(191)
#  deleted_at    :datetime
#  created_at    :datetime
#  updated_at    :datetime
#
# Indexes
#
#  index_socials_on_deleted_at  (deleted_at)
#  index_socials_on_user_id     (user_id) UNIQUE
#
FactoryBot.define do
  factory :social do
    twitter_id { Faker::Internet.uuid }
    youtube_url { Faker::Internet.url }
    instagram_url { Faker::Internet.url }
    facebook_url { Faker::Internet.url }

    association :user
  end
end
