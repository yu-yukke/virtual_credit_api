# frozen_string_literal: true

# == Schema Information
#
# Table name: tag_mappings
#
#  id         :bigint           not null, primary key
#  product_id :bigint           not null
#  tag_id     :bigint           not null
#  deleted_at :datetime
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_tag_mappings_on_deleted_at  (deleted_at)
#  index_tag_mappings_on_product_id  (product_id)
#  index_tag_mappings_on_tag_id      (tag_id)
#
class TagMapping < ApplicationRecord
  acts_as_paranoid

  belongs_to :product
  belongs_to :tag
end
