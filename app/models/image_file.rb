# frozen_string_literal: true

# == Schema Information
#
# Table name: image_files
#
#  id         :bigint           not null, primary key
#  product_id :bigint           not null
#  sequence   :integer          not null
#  file_type  :integer          default("image"), not null
#  image_url  :string(255)
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
  acts_as_paranoid

  enum file_type: {
    image: 0,
    video: 10
  }.freeze

  belongs_to :product
end
