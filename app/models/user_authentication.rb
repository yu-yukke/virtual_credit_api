# frozen_string_literal: true

# == Schema Information
#
# Table name: user_authentications
#
#  id                  :bigint           not null, primary key
#  user_id             :bigint           not null
#  provider            :string(191)      default("email"), not null
#  uid                 :string(191)      default(""), not null
#  remember_created_at :datetime
#  sign_in_count       :integer          default(0), not null
#  current_sign_in_at  :datetime
#  last_sign_in_at     :datetime
#  current_sign_in_ip  :string(255)
#  last_sign_in_ip     :string(255)
#  tokens              :text(65535)
#  deleted_at          :datetime
#  created_at          :datetime
#  updated_at          :datetime
#
# Indexes
#
#  index_user_auths_on_deleted_at           (deleted_at)
#  index_user_auths_on_provider_uid_unique  (provider,uid) UNIQUE
#  index_user_auths_on_user_id              (user_id) UNIQUE
#
class UserAuthentication < ApplicationRecord
  acts_as_paranoid

  extend Devise::Models
  devise :rememberable, :trackable, :omniauthable, omniauth_providers: [:twitter]

  include DeviseTokenAuth::Concerns::User

  belongs_to :user

  class << self
    def find_for_oauth(auth)
      # create authentication
      # user_authentication = UserAuthentication.where(uid: auth[:uid], provider: auth[:provider]).first
    end
  end
end
