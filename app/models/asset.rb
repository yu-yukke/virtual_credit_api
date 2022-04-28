# frozen_string_literal: true

# == Schema Information
#
# Table name: assets
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  name       :string(191)      not null
#  url        :string(255)      not null
#  image_url  :string(255)      not null
#  deleted_at :datetime
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_assets_on_deleted_at  (deleted_at)
#  index_assets_on_user_id     (user_id)
#
class Asset < ApplicationRecord
  acts_as_paranoid

  belongs_to :user

  has_many :asset_mappings, dependent: :destroy
  has_many :works, through: :asset_mappings
end
