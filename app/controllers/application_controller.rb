class ApplicationController < ActionController::Base
  before_action :check_login, only: [:index]

  def index
  end

  private
    def check_login
      redirect_to '/admin/login'
      # redirect_to '/admin/login'
    end
end
