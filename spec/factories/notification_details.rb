# frozen_string_literal: true

FactoryBot.define do
  factory :notification_detail do
    subject { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }

    association :notification
  end
end
