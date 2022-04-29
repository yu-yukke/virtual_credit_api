# frozen_string_literal: true

FactoryBot.define do
  factory :social do
    twitter_id { Faker::Internet.uuid }
    youtube_url { Faker::Internet.url }
    instagram_url { Faker::Internet.url }
    facebook_url { Faker::Internet.url }

    association :user
  end
end
