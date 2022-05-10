# frozen_string_literal: true

# == Schema Information
#
# Table name: release_notes
#
#  id          :bigint           not null, primary key
#  version     :decimal(10, )    not null
#  subject     :string(191)      not null
#  description :text(65535)      not null
#  released_at :datetime         not null
#  deleted_at  :datetime
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  index_release_notes_on_deleted_at  (deleted_at)
#
class ReleaseNote < ApplicationRecord
  acts_as_paranoid

  validates :version, presence: true, uniqueness: true, numericality: true
  validates :subject, presence: true
  validates :description, presence: true
  validates :released_at, presence: true
end
