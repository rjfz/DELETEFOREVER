module Admin
  class RolesController < AdminController
    before_action :add_role_breadcrumbs

    def index
      @roles = Role.all
      breadcrumbs.add 'manage roles'
    end

    def new
      @role = Role.new
    end

    def edit
      @role = Role.find(params[:id])
      @permissions = Permission.all.group_by(&:resource)
      pp @permissions
      breadcrumbs.add @role.role
    end

    def create
      @role = Role.create(params.require(:role).permit(:role))

      if @role.errors.any?
        show_flash :warning, "You absolute fuckup - #{list_of_errors(@role)}"
        render :new
      else
        show_flash :info, 'love you longtime'
        redirect_to edit_admin_role_path(@role)
      end
    end

    def update
      @role = Role.find(params[:id])
      if @role.update(params.require(:role).permit(:role))
        flash[:success] = 'u was right'
      else
        flash[:error] = "bitch the fuck - #{@role.errors.full_messages.join ', '}"
      end
      redirect_to edit_admin_role_path(@role)
    end

    def destroy
      @role = Role.find(params[:id])
      @role.destroy
      redirect_to admin_roles_path
    end

    def add_role_breadcrumbs
      breadcrumbs.add 'manage roles', admin_roles_path
    end
  end
end
