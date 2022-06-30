# frozen_string_literal: true

# == Schema Information
#
# Table name: works
#
#  id          :bigint           not null, primary key
#  category_id :bigint           not null
#  name        :string(191)      not null
#  description :text(65535)      not null
#  deleted_at  :datetime
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  index_works_on_category_id  (category_id)
#  index_works_on_deleted_at   (deleted_at)
#
class WorkSerializer < ApplicationSerializer
  attributes :id, :name, :description, :creators, :number_of_favorites

  belongs_to :category, serializer: CategorySerializer

  has_many :image_files, each_serializer: ImageFileSerializer
  has_many :tags, each_serializer: TagSerializer
  has_many :assets, each_serializer: AssetSerializer

  def creators
    ActiveModelSerializers::SerializableResource.new(
      object.creators, each_serializer: UserSerializer, work_id: object.id
    )
  end

  def number_of_favorites
    object.favorites.count
  end
end
