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
require "rails_helper"

RSpec.describe ReleaseNote, type: :model do
end
