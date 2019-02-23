class Admin::UsersController < Admin::ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def index
    @users = User.where(is_enable: true).order(:email).decorate
  end

  def new
    @users = User.new
  end

  def create
    @users = User.new(user_params)

    if @users.save
      flash[:notice] = 'User successfully added.'
      redirect_to new_admin_user_path
    else
      puts "--------#{@users.errors.full_messages}"
    end
  end

  def edit
  end

  def update
    if @users.update(user_params)
      # redirect_to "/admin/users"
      flash[:notice] = 'User successfully updated.'
      redirect_to edit_admin_user_path(@users.id)
    else
      puts "--------#{@users.errors.full_messages}"
    end
  end

  def delete_user
    u = User.find(params[:id])
    u.update(is_enable: false)
    flash[:notice] = 'User successfully deleted.'
    redirect_to '/admin/users'
  end

  private
    def set_user
      @users = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password_digest, :first_name, :last_name, :user_department_id, :status_id)
    end
end
