# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(params.require(:user).permit(:username, :password, :avatar))

    session[:user_id] = @user.id

    redirect_to action: 'index', controller: 'welcome'
  end

  def signout
    session.delete(:user_id)
    flash[:info] = 'Logged out'
    redirect_to action: 'index', controller: 'welcome'
  end
end
