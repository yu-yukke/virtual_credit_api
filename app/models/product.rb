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
end
