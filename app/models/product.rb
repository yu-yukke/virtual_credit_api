# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  category_id :bigint           not null
#  name        :string(191)      not null
#  description :text(65535)      not null
#  deleted_at  :datetime
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  index_products_on_category_id  (category_id)
#  index_products_on_deleted_at   (deleted_at)
#
class Product < ApplicationRecord
  act_as_paranoid

  belongs_to :category

  has_many :image_files, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user

  has_many :creator_mappings, dependent: :destroy
  has_many :creators, through: :creator_mappings, source: :user

  has_many :tag_mappings, dependent: :destroy
  has_many :tags, through: :tag_mappings

  has_many :asset_mappings, dependent: :destroy
  has_many :assets, through: :asset_mappings
end
