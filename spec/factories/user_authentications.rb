# frozen_string_literal: true

# == Schema Information
#
# Table name: user_authentications
#
#  id                  :bigint           not null, primary key
#  user_id             :bigint           not null
#  provider            :string(191)      default("email"), not null
#  uid                 :string(191)      default(""), not null
#  remember_created_at :datetime
#  sign_in_count       :integer          default(0), not null
#  current_sign_in_at  :datetime
#  last_sign_in_at     :datetime
#  current_sign_in_ip  :string(255)
#  last_sign_in_ip     :string(255)
#  tokens              :text(65535)
#  deleted_at          :datetime
#  created_at          :datetime
#  updated_at          :datetime
#
# Indexes
#
#  index_user_auths_on_deleted_at           (deleted_at)
#  index_user_auths_on_provider_uid_unique  (provider,uid) UNIQUE
#  index_user_auths_on_user_id              (user_id) UNIQUE
#
FactoryBot.define do
  factory :user_login do
    provider { 'twitter' }
    uid { Faker::Number.number(digits: 10) }
    remember_created_at { Faker::Time.backward(days: 7, period: :evening) }
    sign_in_count { 0 }
    current_sign_in_at { Faker::Time.backward(days: 7, period: :evening) }
    last_sign_in_at { Faker::Time.backward(days: 7, period: :evening) }
    current_sign_in_ip { Faker::Internet.ip_v6_address }
    last_sign_in_ip { Faker::Internet.ip_v6_address }
    tokens { Faker::Lorem.characters }

    association :user
  end
end
