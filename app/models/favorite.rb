# frozen_string_literal: true

# == Schema Information
#
# Table name: favorites
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  product_id :bigint           not null
#  deleted_at :datetime
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_favorites_on_deleted_at  (deleted_at)
#  index_favorites_on_product_id  (product_id)
#  index_favorites_on_user_id     (user_id)
#
class Favorite < ApplicationRecord
  act_as_paranoid

  belongs_to :user
  belongs_to :product
end
