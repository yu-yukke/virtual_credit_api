# frozen_string_literal: true

# == Schema Information
#
# Table name: asset_mappings
#
#  id         :bigint           not null, primary key
#  asset_id   :bigint           not null
#  product_id :bigint           not null
#  deleted_at :datetime
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_asset_mappings_on_asset_id    (asset_id)
#  index_asset_mappings_on_deleted_at  (deleted_at)
#  index_asset_mappings_on_product_id  (product_id)
#
class AssetMapping < ApplicationRecord
  act_as_paranoid

  belongs_to :asset
  belongs_to :product
end
