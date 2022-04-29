# frozen_string_literal: true

FactoryBot.define do
  factory :inquiry do
    inquiry_type { "inquire" }
    text { Faker::Lorem.paragraph }

    association :user
  end
end
