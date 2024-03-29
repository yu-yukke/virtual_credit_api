# frozen_string_literal: true

# == Schema Information
#
# Table name: works
#
#  id             :bigint           not null, primary key
#  category_id    :bigint           not null
#  name           :string(191)      not null
#  description    :text(65535)      not null
#  main_image_url :string(255)      not null
#  deleted_at     :datetime
#  created_at     :datetime
#  updated_at     :datetime
#
# Indexes
#
#  index_works_on_category_id  (category_id)
#  index_works_on_deleted_at   (deleted_at)
#
FactoryBot.define do
  factory :work do
    name { Faker::Name.unique.name }
    description { Faker::Lorem.paragraph }
    main_image_url { Faker::Internet.url }

    association :category

    after(:create) do |work|
      FactoryBot.create(:video, work: work)

      FactoryBot.create_list(:image_file, 5, work: work)
      FactoryBot.create_list(:tag_mapping, 5, work: work)
      FactoryBot.create_list(:asset_mapping, 5, work: work)
    end
  end
end
