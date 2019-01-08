class Admin::ApplicationController < ActionController::Base
  layout 'admin_application'
  protect_from_forgery with: :exception
  before_action :check_admin_login, :except => [:login, :login_auth]

  private
    def check_admin_login
      unless session[:user_id].blank?
        @user = User.find(session[:user_id]).decorate
      else
        redirect_to '/admin/login'
      end
    end
end
