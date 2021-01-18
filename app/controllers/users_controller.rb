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

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'u was right'
    else
      flash[:error] = "bitch the fuck - #{@user.errors.full_messages.join ', '}"
    end
    redirect_to controller: 'options', action: 'index'
  end

  def user_params
    params.require(:user).permit(:avatar, :username, :password)
  end
end
