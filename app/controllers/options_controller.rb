# frozen_string_literal: true

class OptionsController < ApplicationController
  before_action :add_options_breadcrumbs
  def index
    @user = current_user
  end

  def change_password
    @user = current_user
    breadcrumbs.add 'Change Password'
  end

  private

  def add_options_breadcrumbs
    breadcrumbs.add 'Options', options_path
  end
end
