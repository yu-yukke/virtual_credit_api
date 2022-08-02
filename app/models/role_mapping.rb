# frozen_string_literal: true

# == Schema Information
#
# Table name: role_mappings
#
#  id                 :bigint           not null, primary key
#  role_id            :bigint           not null
#  creator_mapping_id :bigint           not null
#  deleted_at         :datetime
#  created_at         :datetime
#  updated_at         :datetime
#
# Indexes
#
#  index_role_maps_on_creator_mapping_id  (creator_mapping_id)
#  index_role_maps_on_deleted_at          (deleted_at)
#  index_role_maps_on_role_id             (role_id)
#
class RoleMapping < ApplicationRecord
  acts_as_paranoid

  belongs_to :role
  belongs_to :creator_mapping
end
