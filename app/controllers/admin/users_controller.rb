class Admin::UsersController < Admin::ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def index
    @users = User.all.order(:email).decorate
  end

  def new
    @users = User.new
  end

  def create
    @users = User.new(user_params)

    if @users.save
      redirect_to "/admin/users"
    else
      puts "--------#{@users.errors.full_messages}"
    end
  end

  def edit
  end

  def update
    if @users.update(user_params)
      redirect_to "/admin/users"
    else
      puts "--------#{@users.errors.full_messages}"
    end
  end

  private
    def set_user
      @users = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password_digest, :first_name, :last_name, :user_department_id, :status_id)
    end
end
