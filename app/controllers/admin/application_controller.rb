class Admin::ApplicationController < ActionController::Base
  layout 'admin_application'
  before_action :check_admin_login, :except => [:login]

  private
    def check_admin_login
      session[:user_id] = params[:user_id] if params[:user_id].present?
      unless session[:user_id].blank?
        @user = User.find(session[:user_id]).decorate
      end
    end
end
