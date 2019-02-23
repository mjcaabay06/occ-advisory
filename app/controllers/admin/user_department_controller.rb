class Admin::UserDepartmentController < Admin::ApplicationController
  before_action :set_user_department, only: [:show, :edit, :update, :destroy]
  def index
    @user_department = UserDepartment.where(is_enable: true).order(:description).decorate
  end

  def new
    @user_department = UserDepartment.new
  end

  def create
    @user_department = UserDepartment.new(user_department_params)

    if @user_department.save
      flash[:notice] = 'Department successfully added.'
      redirect_to new_admin_user_department_path
    else
      puts "--------#{@user_department.errors.full_messages}"
    end
  end

  def edit
  end

  def update
    if @user_department.update(user_department_params)
      flash[:notice] = 'Department successfully updated.'
      redirect_to edit_admin_user_department_path(@user_department.id)
    else
      puts "--------#{@user_department.errors.full_messages}"
    end
  end

  def delete_department
    ud = UserDepartment.find(params[:id])
    ud.update(is_enable: false)
    flash[:notice] = 'Department successfully deleted.'
    redirect_to '/admin/departments'
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
      params.require(:user_department).permit(:description, :code, :status_id, :has_time_and_date, :has_attach_advisory, :advisory_category_fields => [], :category_fields => [], :reason_options => [], :remark_options => [])
    end
end
