class Admin::HomeController < Admin::ApplicationController
  def index
  end

  def new
  end

  def memo_filters
    @memos = Memo.by_ac_r(params[:ac_id])
            .by_created(params[:created_date])
            .order('memos.created_at desc').decorate

    render partial: 'memo_lists_body'
  end

  def memo_info
    @memo = Memo.find_by_id(params[:id]).decorate
    render json: {
      partial: render_to_string(partial: 'memo_info_body'),
      title: @memo.memo_title
    }
  end

  def login
    respond_to do |format|
      format.html { render layout: false }
    end
  end

  def login_auth
    alert = 'Invalid authentication!'
    user = User.validate_login(params[:email], params[:password])

    unless user.blank?
      session[:user_id] = user.id
      url = '/admin/advisory/inbox'
      # url = '/admin/memo/inbox'
      if user.user_department_id == 1
        url = '/admin/users'
      end

      redirect_to url
    else
      flash[:status] = false
      flash[:message] = alert
      redirect_back fallback_location: '/admin/login'
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to '/admin/login'
  end

  def check_account
    password = Digest::MD5.hexdigest(params[:password])
    status = :invalid

    if @user.password_digest == password
      status = :valid
    end
    render json: status
  end

  def change_default_password
    password = Digest::MD5.hexdigest(params[:password])
    status = :invalid

    unless @user.password_digest == password
      @user.update(password_digest: password)
      status = :valid
    end
    render json: status
  end

  def reset_password
    user = User.find_by_id(params[:id])
    status = :invalid
    if user.update(password_digest: Digest::MD5.hexdigest('P@ssword'))
      status = :valid
    end
    render json: status
  end

end
