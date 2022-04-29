# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  name            :string(191)      not null
#  description     :string(191)
#  main_image_url  :string(255)
#  thumb_image_url :string(255)
#  deleted_at      :datetime
#  created_at      :datetime
#  updated_at      :datetime
#
# Indexes
#
#  index_users_on_deleted_at  (deleted_at)
#

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    description { Faker::Lorem.paragraph }
    main_image_url { Faker::Internet.url }
    thumb_image_url { Faker::Internet.url }
  end
end
