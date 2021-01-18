# frozen_string_literal: true

class OptionsController < ApplicationController
  def index
    @user = current_user
  end

  def change_password
    @user = current_user
  end
end
