# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :logged_in?
  helper_method :require_login
  helper_method :author_permission

  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def require_login
    return if logged_in?

    show_flash :error, 'You must be logged in to access this section'
    redirect_to '/signin'
  end

  def show_flash(type, message)
    flash[type] = message
  end
end
