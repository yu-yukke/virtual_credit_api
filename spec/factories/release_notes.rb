# frozen_string_literal: true

FactoryBot.define do
  factory :release_note do
    sequence(:version) { |n| n }
    subject { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    released_at { Faker::Time.backward(days: 7, period: :evening) }
  end
end
