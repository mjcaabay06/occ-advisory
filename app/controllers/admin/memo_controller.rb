class Admin::MemoController < Admin::ApplicationController
  include MemoConcern

  MemoCabin = [
    'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'
    ].freeze

  def index
  end
  
  def inbox
    @memos = Memo.filter_inbox(@user.id)
              .order('created_at desc').decorate
  end

  def edit
    @memo = Memo.find_by_sid(params[:id])
    @heading = check_heading(@memo.user.user_department_id)
    @remark_ids = check_remarks_ids(@memo.user.user_department_id)
    @reason_ids = check_reason_ids(@memo.user.user_department_id)
    # binding.pry
  end

  def new
    @memo = Memo.new
    @memo.memo_categories.build
    @heading = check_heading(@user.user_department_id)
    @remark_ids = check_remarks_ids(@user.user_department_id)
    @reason_ids = check_reason_ids(@user.user_department_id)
  end

  def create
    params[:memo][:user_id] = @user.id

    @memo = Memo.new(memo_params(@user.user_department.try(:code)))
    if @memo.save
      flash[:notice] = 'Successfully created new memo.'
      redirect_to "/admin/memo/review-memo/#{@memo.sid}"
    else
      flash[:notice] = 'There was a problem in your application. Please check all fields.'
      redirect_to new_admin_memo_path
    end
  end

  def check_account
    password = Digest::MD5.hexdigest(params[:password])
    status = :invalid

    if @user.password_digest == password
      status = :valid
    end
    render json: status
  end

  def review_memo
    @memo = Memo.find_by_sid(params[:sid]).decorate
    @category_ids = @memo.memo_categories.select('distinct(category_id)').order(:category_id).collect{|mc| mc.category_id}
    @incoordination = User.where(id: @memo.incoordinate_with).collect{ |u| "#{u.first_name}-#{u.user_department.code}" }.join(', ')
  end

  def send_memo
    memo = Memo.find_by_sid(params[:sid])
    memo.update_attributes(is_viewable: true)
    redirect_to '/admin/memo'
  end

  def memo_filter
    memo_ids = Memo.select('distinct(memos.id)').filter_joins
    is_memo = false
    unless params[:val].blank?
      memo_ids = memo_ids.filter_text(params[:val])
      is_memo = true
    end
    unless params[:flight_date].blank?
      memo_ids = memo_ids.filter_flight_date(params[:flight_date])
      is_memo = true
    end
    unless params[:dept_id].blank?
      memo_ids = memo_ids.filter_department(params[:dept_id])
      is_memo = true
    end

    @memos = Memo.filter_inbox(@user.id)
    
    if is_memo
      @memos = @memos.where(id: memo_ids)
    end

    @memos = @memos.order('created_at desc').decorate
    render partial: 'inbox_body'
  end

  private
    def get_proper_params dept_code
      case dept_code.downcase
      when 'ltp'
        ltp_params
      when 'fmd'
        fmd_params
      when 'rmd'
        rmd_params
      when 'csd'
        csd_params
      when 'cfd'
        cfd_params
      when 'airport terminal'
        at_params
      when 'sp'
        sp_params
      end
    end

    def memo_params dept_code
      params[:memo][:recipients] = params[:memo][:recipients].reject { |c| c.empty? }
      params[:memo][:incoordinate_with] = params[:memo][:incoordinate_with].reject { |c| c.empty? }
      params[:memo][:reasons] = params[:memo][:reasons].reject { |c| c.empty? } if params[:memo][:reasons].present?
      params[:memo][:remarks] = params[:memo][:remarks].reject { |c| c.empty? } if params[:memo][:remarks].present?

      params.require(:memo).permit(
          :user_id,
          :time_and_date,
          get_proper_params(dept_code),
          :recipients => [],
          :incoordinate_with => [],
          :reasons => [], 
          :remarks => [],
        )
    end

    def ltp_params
      {:memo_categories_attributes => [
        :category_id, :effective_date, :ac_registry, :flight_number, :ac_status_datetime, :remarks
      ]}
    end

    def rmd_params
      {:memo_categories_attributes => [
        :effective_date, :ac_registry, :flight_number, :load_b,
        :load_p, :load_e, :remarks
      ]}
    end

    def csd_params
      {:memo_categories_attributes => [
        :ac_registry, :aircraft_type_id, :flight_number, :flight_date,
        :remarks
      ]}
    end

    def cfd_params
      {:memo_categories_attributes => [
        :category_id, :location, :movement, :max_wind,
        :weather_forecast, :ac_registry, :remarks, :route_origin, :route_destination,
        :ac_location, :ac_status_datetime 
      ]}
    end

    def at_params
      {:memo_categories_attributes => [
        :tow_out, :tow_in, :blocked_in, :ac_registry,
        :cockpit_crew_boarded, :cabin_crew_boarded, :general_boarding,
        :baggage_cargo_loaded, :close_door, :push_back, :air_bourne, :remarks
      ]}
    end

    def fmd_params
      {:memo_categories_attributes => [
        :apu_inoperative, :seat_blocks, :no_avi, :restriction,
        :acu_problem, :ac_on_ground, :remarks
      ]}
    end

    def sp_params
      {:memo_categories_attributes => [
        :flight_date, :flight_number, :route_origin, :route_destination,
        :ac_registry, :aircraft_type_id, :ac_configuration, :std, :sta, :nstd, :nsta,
        :frequency_id, :remarks
      ]}
    end
end
