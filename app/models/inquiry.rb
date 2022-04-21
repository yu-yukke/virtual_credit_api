# frozen_string_literal: true

# == Schema Information
#
# Table name: inquiries
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  type       :integer          not null
#  text       :text(65535)      not null
#  deleted_at :datetime
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_inquiries_on_deleted_at  (deleted_at)
#  index_inquiries_on_user_id     (user_id)
#
class Inquiry < ApplicationRecord
end
