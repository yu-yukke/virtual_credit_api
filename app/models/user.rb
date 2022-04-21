# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id          :bigint           not null, primary key
#  name        :string(191)      not null
#  description :string(191)
#  main_image  :string(191)
#  thumb_image :string(191)
#  deleted_at  :datetime
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  index_users_on_deleted_at  (deleted_at)
#
class User < ApplicationRecord
  act_as_paranoid

  has_one :user_login, dependent: :destroy
  has_one :social, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favorite_products, through: :favorites, source: :product

  has_many :creator_mappings, dependent: :destroy
  has_many :products, through: :creator_mappings

  has_many :tags
  has_many :assets
  has_many :inquiries, dependent: :destroy
end
