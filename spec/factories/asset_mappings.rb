# frozen_string_literal: true

# == Schema Information
#
# Table name: asset_mappings
#
#  id         :bigint           not null, primary key
#  asset_id   :bigint           not null
#  work_id    :bigint           not null
#  deleted_at :datetime
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_asset_mappings_on_asset_id    (asset_id)
#  index_asset_mappings_on_deleted_at  (deleted_at)
#  index_asset_mappings_on_work_id     (work_id)
#
FactoryBot.define do
  factory :asset_mappings do
    association :asset
    association :work
  end
end
