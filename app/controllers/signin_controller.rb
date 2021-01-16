# frozen_string_literal: true

class SigninController < ApplicationController
  def signin
    @user = User.find_by(username: params[:username])
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to '/welcome/index'
    else
      flash[:warning] = 'Incorrect details. Please try logging in again.'
      redirect_to '/signin'
    end
  end
end
