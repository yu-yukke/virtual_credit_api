FactoryBot.define do
  factory :job do
    name { Faker::Name.name }
    ancestry { nil }
  end
end
