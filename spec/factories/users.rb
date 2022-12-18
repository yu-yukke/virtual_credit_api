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
    name { Faker::Name.unique.name }
    description { Faker::Lorem.paragraph }
    main_image_url { Faker::Internet.url }
    thumb_image_url { Faker::Internet.url }
  end

  after(:create) do |user|
    if user.class.name == "User"
      FactoryBot.create(:social, user: user)

      parent = Job.where(ancestry: nil).first || FactoryBot.create(:job)
      child = Job.where.not(ancestry: nil).first || FactoryBot.create(:job, ancestry: parent.id.to_s)
      FactoryBot.create(:job_mapping, user: user, job: child)
    end
  end
end
