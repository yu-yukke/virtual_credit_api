# frozen_string_literal: true

# == Schema Information
#
# Table name: admin_users
#
#  id              :bigint           not null, primary key
#  name            :string(191)      not null
#  email           :string(191)      not null
#  password_digest :string(191)      not null
#  deleted_at      :datetime
#  created_at      :datetime
#  updated_at      :datetime
#
# Indexes
#
#  index_admin_users_on_deleted_at          (deleted_at)
#  index_admin_users_on_email               (email)
#  index_admin_users_on_email_deleted_uniq  (email,deleted_at) UNIQUE
#  index_admin_users_on_password_digest     (password_digest) UNIQUE
#
class AdminUser < ApplicationRecord
  act_as_paranoid
end
