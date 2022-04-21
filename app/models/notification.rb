# frozen_string_literal: true

# == Schema Information
#
# Table name: notifications
#
#  id         :bigint           not null, primary key
#  start_at   :datetime         not null
#  end_at     :datetime
#  deleted_at :datetime
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_notifications_on_deleted_at  (deleted_at)
#
class Notification < ApplicationRecord
  act_as_paranoid

  has_many :notification_details, dependent: :destroy
end
