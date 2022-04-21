# frozen_string_literal: true

# == Schema Information
#
# Table name: notification_details
#
#  id              :bigint           not null, primary key
#  notification_id :bigint           not null
#  subject         :string(191)      not null
#  description     :text(65535)      not null
#  deleted_at      :datetime
#  created_at      :datetime
#  updated_at      :datetime
#
# Indexes
#
#  notification_details_on_deleted_at       (deleted_at)
#  notification_details_on_notification_id  (notification_id)
#
class NotificationDetail < ApplicationRecord
  acts_as_paranoid

  belongs_to :notification
end
