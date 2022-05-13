# frozen_string_literal: true

# == Schema Information
#
# Table name: release_notes
#
#  id          :bigint           not null, primary key
#  version     :string(255)      not null
#  subject     :string(191)      not null
#  description :text(65535)      not null
#  released_at :datetime         not null
#  deleted_at  :datetime
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  index_release_notes_on_deleted_at  (deleted_at)
#
FactoryBot.define do
  factory :release_note do
    sequence(:version) { |n| n }
    subject { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    released_at { Faker::Time.backward(days: 7, period: :evening) }
  end
end
