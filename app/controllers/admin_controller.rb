# frozen_string_literal: true

class AdminController < ApplicationController
  before_action :add_admin_breadcrumbs
  before_action :authorize_admin

  def authorize_admin
    return if admin?

    show_flash :error, 'suck your mother'

    redirect_to root_path
  end

  private

  def add_admin_breadcrumbs
    breadcrumbs.add 'admin', admin_users_path
  end
end
