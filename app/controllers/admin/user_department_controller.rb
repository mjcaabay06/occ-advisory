class Admin::UserDepartmentController < Admin::ApplicationController
  before_action :set_user_department, only: [:show, :edit, :update, :destroy]
  def index
    @user_department = UserDepartment.all.order(:description).decorate
  end

  def new
    @user_department = UserDepartment.new
  end

  def create
    @user_department = UserDepartment.new(user_department_params)

    if @user_department.save
      redirect_to "/admin/departments"
    else
      puts "--------#{@user_department.errors.full_messages}"
    end
  end

  def edit
  end

  def update
    if @user_department.update(user_department_params)
      redirect_to "/admin/departments"
    else
      puts "--------#{@user_department.errors.full_messages}"
    end
  end

  private
    def set_user_department
      @user_department = UserDepartment.find(params[:id])
    end

    def user_department_params
      params[:user_department][:advisory_category_fields] = params[:user_department][:advisory_category_fields].reject { |c| c.empty? } if params[:user_department][:advisory_category_fields].present?
      params[:user_department][:category_fields] = params[:user_department][:category_fields].reject { |c| c.empty? } if params[:user_department][:category_fields].present?
      params[:user_department][:reason_options] = params[:user_department][:reason_options].reject { |c| c.empty? } if params[:user_department][:reason_options].present?
      params[:user_department][:remark_options] = params[:user_department][:remark_options].reject { |c| c.empty? } if params[:user_department][:remark_options].present?
      params.require(:user_department).permit(:description, :code, :status_id, :advisory_category_fields => [], :category_fields => [], :reason_options => [], :remark_options => [])
    end
end
