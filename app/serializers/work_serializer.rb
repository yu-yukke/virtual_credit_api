# frozen_string_literal: true

# == Schema Information
#
# Table name: works
#
#  id             :bigint           not null, primary key
#  category_id    :bigint           not null
#  name           :string(191)      not null
#  description    :text(65535)      not null
#  main_image_url :string(255)      not null
#  deleted_at     :datetime
#  created_at     :datetime
#  updated_at     :datetime
#
# Indexes
#
#  index_works_on_category_id  (category_id)
#  index_works_on_deleted_at   (deleted_at)
#
class WorkSerializer < ApplicationSerializer
  attributes :id, :name, :main_image_url
  attribute :description, if: -> { instance_options[:with_details] }
  attribute :creators, if: -> { instance_options[:with_details] }
  attribute :roles, if: -> { instance_options[:with_details] }

  belongs_to :category, serializer: CategorySerializer

  has_one :author, serializer: AuthorSerializer, if: -> { instance_options[:with_details] }
  has_one :video, serializer: VideoSerializer, if: -> { instance_options[:with_details] }

  has_many :image_files, each_serializer: ImageFileSerializer, if: -> { instance_options[:with_details] || instance_options[:with_images] }
  has_many :tags, each_serializer: TagSerializer, if: -> { instance_options[:with_details] }
  has_many :assets, each_serializer: AssetSerializer, if: -> { instance_options[:with_details] }
  has_many :link_in_bios, each_serializer: LinkInBioSerializer, if: -> { instance_options[:with_details] }

  def creators
    ActiveModelSerializers::SerializableResource.new(
      object.creators, each_serializer: UserSerializer, work_id: object.id
    )
  end

  def roles
    ActiveModelSerializers::SerializableResource.new(
      object.roles, each_serializer: RoleSerializer, work_id: object.id
    )
  end
end
