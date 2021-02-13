# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)

    can :manage, :all if admin? user

    can :read, :all

    user.roles.each do |role|
      role.role_permissions.each do |role_permission|
        if role_permission.enabled?
          can role_permission.permission.command.to_sym, role_permission.permission.resource.camelcase.constantize
        end
      end
    end

    setup_own_permissions(user)
  end

  private

  def setup_own_permissions(user)
    can :update, Article, author_id: user.id
    can :update, Comment, commenter_id: user.id
    can :delete, Article, author_id: user.id
    can :delete, Comment, commenter_id: user.id
  end

  def admin?(user)
    user.roles.find_by(role: 'admin')
  end
end
