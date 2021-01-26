# frozen_string_literal: true

module Admin
  class UsersController < AdminController
    def index
      @users = User.all
      breadcrumbs.add 'manage users'
    end

    def new
      @user = User.new
    end

    def edit
      @user = User.find(params[:id])
      breadcrumbs.add @user.username
    end

    def create
      @user = User.create(params.require(:user).permit(:username, :password, :avatar, :password_confirmation))

      if @user.errors.any?
        show_flash :warning, "You absolute fuckup - #{list_of_errors(@user)}"
        render :new
      else
        show_flash :info, 'love you longtime'
        session[:user_id] = @user.id
        redirect_to action: 'index', controller: 'welcome'
      end
    end

    def update
      @user = User.find(params[:id])
      if @user.update(params.require(:user).permit(:avatar, :username))
        flash[:success] = 'u was right'
      else
        flash[:error] = "bitch the fuck - #{@user.errors.full_messages.join ', '}"
      end
      redirect_to edit_admin_user_path(@user)
    end

    def ban_time
      user = User.find(params[:id])
      user.ban_time = Time.now
      user.save
      redirect_to edit_admin_user_path(user)
    end

    def unban_user
      user = User.find(params[:id])
      user.ban_time = nil
      user.save
      redirect_to edit_admin_user_path(user)
    end
  end
end
