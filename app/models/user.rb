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
class User < ApplicationRecord
  acts_as_paranoid

  has_one :user_authentication, dependent: :destroy
  has_one :social, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favorite_works, through: :favorites, source: :work

  has_many :job_mappings, dependent: :destroy
  has_many :jobs, through: :job_mappings

  has_many :creator_mappings, dependent: :destroy
  has_many :works, through: :creator_mappings

  has_many :tags
  has_many :assets
  has_many :inquiries, dependent: :destroy
end
