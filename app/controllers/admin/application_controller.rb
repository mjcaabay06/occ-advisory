class Admin::ApplicationController < ActionController::Base
  layout 'admin_application'
  before_action :check_admin_login

  private
    def check_admin_login
      unless params[:user_id].blank?
        @user = User.find(params[:user_id]).decorate
      end
    end
end
