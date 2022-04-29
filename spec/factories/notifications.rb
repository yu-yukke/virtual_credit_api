# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    start_at { Faker::Time.backward(days: 14, period: :evening) }
    end_at { Faker::Time.backward(days: 7, period: :evening) }
  end
end
