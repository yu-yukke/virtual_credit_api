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
class Work < ApplicationRecord
  acts_as_paranoid

  belongs_to :category

  has_one :author_mapping, -> { where(is_author: true) }, class_name: "CreatorMapping"
  has_one :author, through: :author_mapping, source: :user

  has_many :image_files, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user

  has_many :creator_mappings, dependent: :destroy
  has_many :creators, through: :creator_mappings, source: :user

  has_many :tag_mappings, dependent: :destroy
  has_many :tags, through: :tag_mappings

  has_many :asset_mappings, dependent: :destroy
  has_many :assets, through: :asset_mappings

  has_many :link_in_bios, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :main_image_url, presence: true
end
