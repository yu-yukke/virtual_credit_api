# frozen_string_literal: true

class JobSerializer < ApplicationSerializer
  attributes :id, :name, :ancestry, :number_of_users

  def number_of_users
    object.users.count
  end
end
