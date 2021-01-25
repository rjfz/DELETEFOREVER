# frozen_string_literal: true

class SigninController < ApplicationController
  def signin
    @user = User.find_by(username: params[:username])

    if banned?
      flash[:error] = 'You are not allowed ever on my amazing website. You complete wanker.'
      redirect_to '/welcome/index'
    elsif authenticated?
      session[:user_id] = @user.id
      redirect_to '/welcome/index'
    else
      flash[:warning] = 'Incorrect details. Please try logging in again.'
      redirect_to '/signin'
    end
  end

  def banned?
    @user.ban_time
  end

  def authenticated?
    @user&.authenticate(params[:password])
  end
end
