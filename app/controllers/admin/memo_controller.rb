class Admin::MemoController < Admin::ApplicationController
  include MemoConcern

  before_action :set_user

  MemoCabin = [
    'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'
    ].freeze

  def index
  end

  def new
    @memo = Memo.new
    @memo.build_load
  end

  def create
    params[:memo][:user_id] = @user.id

    @memo = Memo.new(ltp_params)
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
    def set_user
      @user = User.find(1).decorate
    end

    def ltp_params
      params.require(:memo).permit(:international_flight_date, :aircraft_registry_id, :flight_number, :remarks, :user_id)
    end

    def rmd_params
      params.require(:memo).permit(:aircraft_registry_id, :flight_date, :purpose, :remarks, :user_id,
        :load_attributes => [
          :seat_number,
          :specific_cabin
        ])
    end

    def csd_params
      params.require(:memo).permit(:cabin_crew_availablity, :remarks, :user_id)
    end

    def cfd_params
      params.require(:memo).permit(:aircraft_registry_id, :flight_date, :purpose, :remarks, :user_id, :weather_condition,
        :load_attributes => [
          :seat_number,
          :specific_cabin
        ])
    end

    def at_params
      params.require(:memo).permit(:aircraft_registry_id, :tow_out, :tow_in, :block_in, :purpose, :cockpit_crew_boarding, :cabin_crew_boarding, :general_boarding, :cargo_boarding, :aircraft_status, :remarks, :user_id)
    end

    def fmd_params
      spl = params[:memo][:flight_monitoring].split(' ')
      date = clean_date(spl[0])
      time = clean_time("#{spl[1]} spl[2]")
      params[:memo][:flight_monitoring] = "#{date} #{time}".to_datetime

      params.require(:memo).permit(:flight_monitoring, :aircraft_on_ground, :status, :aircraft_inoperative, :seat_block, :no_avi, :restriction, :airconditioning, :remarks, :user_id)
    end

    def sp_params
      params.require(:memo).permit(:flight_date, :flight_number, :route, :aircraft_type, :aircraft_configuration, :std, :sta, :frequency, :remarks, :user_id)
    end
end
