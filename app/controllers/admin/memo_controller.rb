class Admin::MemoController < Admin::ApplicationController
  include MemoConcern

  MemoCabin = [
    'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'
    ].freeze

  def index
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
    else
      flash[:notice] = 'There was a problem in your application. Please check all fields.'
    end
    redirect_to new_admin_memo_path
  end

  def check_account
    password = Digest::MD5.hexdigest(params[:password])
    status = :invalid

    if @user.password_digest == password
      status = :valid
    end
    render json: status
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
      # params.require(:memo).permit(:international_flight_date, :aircraft_registry_id, :flight_number, :remarks, :user_id)
    end

    def rmd_params
      {:memo_categories_attributes => [
        :effective_date, :ac_registry, :flight_number, :load_b,
        :load_p, :load_e, :remarks
      ]}
    end

    def csd_params
      params.require(:memo).permit(:cabin_crew_availablity, :remarks, :user_id)
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
