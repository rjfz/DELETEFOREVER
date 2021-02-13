# frozen_string_literal: true

class Permission < ApplicationRecord
  has_many :role_permissions
  has_many :roles, through: :role_permissions

  after_create :create_role_permissions
  def create_role_permissions
    Role.all.each do |role|
      RolePermission.create!(role_id: role.id, permission_id: id, enabled: false)
    end
  end
end
