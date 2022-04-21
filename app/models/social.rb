# == Schema Information
#
# Table name: socials
#
#  id           :bigint           not null, primary key
#  user_id      :bigint           not null
#  twitter_id   :string(191)
#  youtube_id   :string(191)
#  instagram_id :string(191)
#  facebook_id  :string(191)
#  deleted_at   :datetime
#  created_at   :datetime
#  updated_at   :datetime
#
# Indexes
#
#  index_socials_on_deleted_at  (deleted_at)
#  index_socials_on_user_id     (user_id) UNIQUE
#
class Social < ApplicationRecord

end
