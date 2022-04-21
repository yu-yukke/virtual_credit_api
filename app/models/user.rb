# == Schema Information
#
# Table name: users
#
#  id          :bigint           not null, primary key
#  name        :string(191)      not null
#  description :string(191)
#  main_image  :string(191)
#  thumb_image :string(191)
#  deleted_at  :datetime
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  index_users_on_deleted_at  (deleted_at)
#
class User < ApplicationRecord

end
