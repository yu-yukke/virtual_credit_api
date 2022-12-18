# frozen_string_literal: true

# == Schema Information
#
# Table name: socials
#
#  id            :bigint           not null, primary key
#  user_id       :bigint           not null
#  twitter_url   :string(191)      not null
#  youtube_url   :string(191)
#  instagram_url :string(191)
#  facebook_url  :string(191)
#  deleted_at    :datetime
#  created_at    :datetime
#  updated_at    :datetime
#
# Indexes
#
#  index_socials_on_deleted_at  (deleted_at)
#  index_socials_on_user_id     (user_id) UNIQUE
#
class SocialSerializer < ApplicationSerializer
  attributes :id, :twitter_url, :youtube_url, :instagram_url, :facebook_url
end
