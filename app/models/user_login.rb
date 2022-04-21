# frozen_string_literal: true

# == Schema Information
#
# Table name: user_logins
#
#  id                :bigint           not null, primary key
#  user_id           :bigint           not null
#  email             :string(191)      not null
#  password_digest   :string(191)      not null
#  last_logged_in_at :datetime         not null
#  deleted_at        :datetime
#  created_at        :datetime
#  updated_at        :datetime
#
# Indexes
#
#  index_user_logins_on_deleted_at          (deleted_at)
#  index_user_logins_on_email               (email)
#  index_user_logins_on_email_deleted_uniq  (email,deleted_at) UNIQUE
#  index_user_logins_on_password_digest     (password_digest) UNIQUE
#  index_user_logins_on_user_id             (user_id) UNIQUE
#
class UserLogin < ApplicationRecord
end
