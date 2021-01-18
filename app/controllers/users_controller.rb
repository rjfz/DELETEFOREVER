# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(params.require(:user).permit(:username, :password, :avatar))

    if @user.errors.any?
      show_flash :warning, "You absolute fuckup - #{@user.errors.full_messages.join ', '}"
      render :new
    else
      show_flash :info, 'love you longtime'
      session[:user_id] = @user.id
      redirect_to action: 'index', controller: 'welcome'
    end
  end

  def signout
    session.delete(:user_id)
    flash[:info] = 'Logged out'
    redirect_to action: 'index', controller: 'welcome'
  end

  def update
    @user = User.find(params[:id])
    if @user.update(params.require(:user).permit(:avatar, :username))
      flash[:success] = 'u was right'
    else
      flash[:error] = "bitch the fuck - #{@user.errors.full_messages.join ', '}"
    end
    redirect_to controller: 'options', action: 'index'
  end

  def update_password
    @user = User.find(params[:id])
    if @user.update(params.require(:user).permit(:password))
      flash[:success] = 'u was right'
    else
      flash[:error] = "bitch the fuck - #{@user.errors.full_messages.join ', '}"
    end
    redirect_to controller: 'options', action: 'change_password'
  end
end
