class Admin::MemoController < Admin::ApplicationController
  def index
  end

  def new
    @user = User.find(1)
  end
end
