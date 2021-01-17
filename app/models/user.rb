# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :comments, foreign_key: :commenter
  has_many :articles, foreign_key: :author
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_one_attached :avatar

  after_create :assign_default_role

  def small
    avatar.variant(resize_and_pad: [64, 64], convert: 'png').processed
  end

  def medium
    avatar.variant(resize_and_pad: [256, 256], convert: 'png').processed
  end

  def large
    avatar.variant(resize_and_pad: [512, 512], convert: 'png').processed
  end

  def assign_default_role
    roles << Role.find_by(role: "member")
  end
end