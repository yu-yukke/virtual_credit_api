# frozen_string_literal: true

# == Schema Information
#
# Table name: roles
#
#  id         :bigint           not null, primary key
#  name       :string(191)      not null
#  deleted_at :datetime
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_roles_on_deleted_at  (deleted_at)
#
class RoleSerializer < ApplicationSerializer
  attributes :id, :name
  attribute :creators, if: -> { instance_options[:work_id] }

  def creators
    work = Work.find_by id: instance_options[:work_id]
    creator_mapping_ids = object.role_mappings.pluck(:creator_mapping_id)
    creator_mappings = work.creator_mappings.where(id: creator_mapping_ids)
    creators = creator_mappings.map { |map| map.user }

    ActiveModelSerializers::SerializableResource.new(
      creators, each_serializer: UserSerializer
    )
  end
end
