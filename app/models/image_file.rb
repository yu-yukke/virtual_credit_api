# frozen_string_literal: true

# == Schema Information
#
# Table name: image_files
#
#  id         :bigint           not null, primary key
#  product_id :bigint           not null
#  sequence   :integer          not null
#  type       :integer          not null
#  image_url  :string(191)
#  video_id   :string(191)
#  deleted_at :datetime
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_image_files_on_deleted_at  (deleted_at)
#  index_image_files_on_product_id  (product_id)
#
class ImageFile < ApplicationRecord
  act_as_paranoid

  belongs_to :product
end
