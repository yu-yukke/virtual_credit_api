# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  name            :string(191)      not null
#  description     :string(191)
#  main_image_url  :string(255)
#  thumb_image_url :string(255)
#  deleted_at      :datetime
#  created_at      :datetime
#  updated_at      :datetime
#
# Indexes
#
#  index_users_on_deleted_at  (deleted_at)
#
class UserSerializer < ApplicationSerializer
  attributes :id, :name, :thumb_image_url
  attribute :is_author, if: -> { instance_options[:work_id] }
  attribute :main_image_url, if: -> { instance_options[:with_details] }
  attribute :description, if: -> { instance_options[:with_details] }

  has_one :social, serializer: SocialSerializer, if: -> { instance_options[:with_details] }

  has_many :works, each_serializer: WorkSerializer, if: -> { instance_options[:with_relations] }
  has_many :jobs, each_serializer: JobSerializer, if: -> { instance_options[:with_relations] }

  def is_author
    object.creator_mappings.find_by(
      work_id: instance_options[:work_id]
    ).is_author
  end
end
