class AddEnabledToRolePermissions < ActiveRecord::Migration[6.0]
  def change
    add_column :role_permissions, :enabled, :boolean
  end
end
