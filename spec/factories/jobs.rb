# frozen_string_literal: true

FactoryBot.define do
  factory :job do
    name { Faker::Name.name }
    ancestry { nil }
  end
end
