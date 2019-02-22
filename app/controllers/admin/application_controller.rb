class Admin::ApplicationController < ActionController::Base
  layout 'admin_application'
  protect_from_forgery with: :exception
  before_action :check_admin_login, :check_inbox, :except => [:login, :login_auth]

  private
    def check_admin_login
      unless session[:user_id].blank?
        @user = User.find(session[:user_id]).decorate
      else
        redirect_to '/admin/login'
      end
    end

    def check_inbox
      @inbox_count = Inbox.where(recipient: @user.id, is_read: false).where.not(sender: @user.id).count
    end

    def check_head_access_url
      # @head_controller = 'memo'
      # if [8].include?(@user.user_department_id)
      #   @head_controller = 'advisory'
      # end
    end
end
