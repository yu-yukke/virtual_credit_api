# frozen_string_literal: true

# == Schema Information
#
# Table name: link_in_bios
#
#  id         :bigint           not null, primary key
#  work_id    :bigint           not null
#  name       :string(191)      not null
#  url        :string(255)      not null
#  deleted_at :datetime
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_link_in_bios_on_deleted_at  (deleted_at)
#  index_link_in_bios_on_work_id     (work_id)
#
class LinkInBioSerializer < ApplicationSerializer
  attributes :id, :name, :url
end
