# frozen_string_literal: true

class AdminController < ApplicationController
  before_action :authorize_admin

  def authorize_admin
    return if admin?

    show_flash :error, 'suck your mother'

    redirect_to root_path
  end
end
