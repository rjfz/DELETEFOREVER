# frozen_string_literal: true

class Role < ApplicationRecord
  has_many :role_permissions
  has_many :permissions, through: :role_permissions
  has_many :user_roles
  has_many :users, through: :user_roles

  after_create_commit { broadcast_append_to "roles"}
  after_update_commit { broadcast_replace_to "roles"}
  after_destroy_commit { broadcast_remove_to "roles"}
end
