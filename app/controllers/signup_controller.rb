# frozen_string_literal: true

class SignupController < ApplicationController
  def new
    @user = User.new
  end
end
