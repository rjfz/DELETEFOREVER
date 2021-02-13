# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
permissions = {
  article: %w[create read update delete],
  comment: %w[update delete create]
}
permissions.each do |resource, commands|
  commands.each do |command|
    Permission.create!(resource: resource, command: command)
  end
end

roles = {
  'Admin' => {
    article: %w[create read update delete],
    comment: %w[update delete create]
  },
  'User' => {
    article: %w[create read update delete],
    comment: %w[update delete create]
  }
}
roles.each do |role, permissions|
  role = Role.create!(role: role)
  permissions.each do |resource, commands|
    commands.each do |command|
      permission = Permission.find_by!(resource: resource, command: command)
      RolePermission.find_by!(role_id: role.id, permission_id: permission.id).update(enabled: true)
    end
  end
end

# froggy = User.create! username: 'Froggy', password: '12345', password_confirmation: '12345', avatar: File.open('db/seeds/Etgfbm1XAAAWkdX.jpg')
# sir_frwoggy = User.create! username: 'sir frwoggy', password: '12345', password_confirmation: '12345', avatar: File.open('db/seeds/Etgfbm1XAAAWkdX.jpg')
# User.create! username: 'Fwoggy', password: '12345', password_confirmation: '12345', avatar: File.open('db/seeds/Etgfbm1XAAAWkdX.jpg')
# Article.create! title: 'Fwoggy adventure', text: 'WAPWAPWAPWAPWAP', author: froggy
# admin = Role.find_by!(role: 'Admin')
# UserRole.create!(user: sir_frwoggy, role: admin)
