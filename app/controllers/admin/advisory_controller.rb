class Admin::AdvisoryController < Admin::ApplicationController
  before_action :set_advisory, only: [:edit, :update, :delete_advisory_reason]
  include AdvisoryConcern

  def index
    @advisory = Advisory.where(user_id: @user.id, is_viewable: true).order('created_at desc').decorate
  end

  def inbox
    @advisories = Inbox.by_recipient(@user.id).where.not(sender: @user.id).order('created_at desc').decorate
  end

  def new
    @advisory = Advisory.new
    @advisory.advisory_reasons.build.advisory_categories.build
    @heading = check_heading(@user.user_department_id)
    @remark_ids = check_remarks_ids(@user.user_department_id)
    @reason_ids = check_reason_ids(@user.user_department_id)

    unless params[:sid].blank?
      if params[:add] == 'true'
        flash[:notice] = nil
      end
      @adv = Advisory.find_by_sid(params[:sid]).try(:id)
    end
  end

  def create
    params[:advisory][:user_id] = @user.id

    
    if params[:advisory][:add_adv_id].present?
      @advisory = AdvisoryReason.new(add_reason_params)
      @advisory.advisory_id = params[:advisory][:add_adv_id]
    else
      @advisory = Advisory.new(advisory_params(@user.user_department.try(:code)))
    end

    if @advisory.save
      sid = params[:advisory][:add_adv_id].present? ? params[:advisory][:adv_sid] : @advisory.sid
      if params[:advisory][:connect_adv_id].present?
        AdvisoryRelation.create(dept_advisory: params[:advisory][:connect_adv_id],
                                occ_advisory: @advisory.id, user_id: @user.id)
      end
      flash[:notice] = 'Successfully created new advisory.'
      redirect_to "/admin/advisory/review-advisory/#{sid}"
    else
      puts "--------#{@advisory.errors.full_messages}"
      flash[:notice] = 'There was a problem in your application. Please check all fields.'
      redirect_to new_admin_advisory_path
    end
  end

  def edit
    @heading = check_heading(@user.user_department_id)
    @remark_ids = check_remarks_ids(@user.user_department_id)
    @reason_ids = check_reason_ids(@user.user_department_id)
  end

  def update
    ids = []
    params[:advisory][:advisory_reasons_attributes].each do |k,v|
      ar = AdvisoryReason.find(v['id'].to_i)
      remarks = v['remarks'].blank? ? '' : v['remarks'].reject { |c| c.empty? }
      ar.update_attributes(
        reasons: v['reasons'].to_s.split('').reject { |c| c.empty? },
        remarks: remarks,
        time_and_date: v['time_and_date'],
        other_remarks: v['other_remarks'],
      )

      v['advisory_categories_attributes'].each do |k,v|
        frequencies = v['frequencies'].blank? ? '' : v['frequencies'].reject { |c| c.empty? }
        data = {
          ac_configuration: v['ac_configuration'],
          ac_location: v['ac_location'],
          ac_on_ground: v['ac_on_ground'],
          ac_registry: v['ac_registry'],
          ac_status_datetime: v['ac_status_datetime'],
          acu_problem: v['acu_problem'],
          air_bourne: v['air_bourne'],
          aircraft_type_id: v['aircraft_type_id'],
          apu_inoperative: v['apu_inoperative'],
          baggage_cargo_loaded: v['baggage_cargo_loaded'],
          blocked_in: v['blocked_in'],
          cabin_crew_boarded: v['cabin_crew_boarded'],
          category_id: v['category_id'],
          close_door: v['close_door'],
          cockpit_crew_boarded: v['cockpit_crew_boarded'],
          effective_date: v['effective_date'],
          flight_date: v['flight_date'],
          flight_number: v['flight_number'],
          frequencies: frequencies,
          general_boarding: v['general_boarding'],
          load_b: v['load_b'],
          load_e: v['load_e'],
          load_p: v['load_p'],
          location: v['location'],
          max_wind: v['max_wind'],
          movement: v['movement'],
          no_avi: v['no_avi'],
          nsta: v['nsta'],
          nstd: v['nstd'],
          push_back: v['push_back'],
          remarks: v['remarks'],
          restriction: v['restriction'],
          route_destination: v['route_destination'],
          route_origin: v['route_origin'],
          seat_blocks: v['seat_blocks'],
          sta: v['sta'],
          std: v['std'],
          tow_in: v['tow_in'],
          tow_out: v['tow_out'],
          weather_forecast: v['weather_forecast'],
          arrival_terminal: v['arrival_terminal'],
          departure_terminal: v['departure_terminal'],
          duration_of_delay: v['duration_of_delay'],
          eta: v['eta'],
          etd: v['etd'],
          neta: v['neta'],
          netd: v['netd'],
          pax: v['pax'],
          touchdown: v['touchdown']
        }
        unless v['id'].blank?
          ac = AdvisoryCategory.find(v['id'])
          ac.update_attributes(data)
          ids << v['id'].to_i
        else
          ac_id = AdvisoryCategory.new(data.merge(advisory_reason_id: ar.id))
          ac_id.save
          ids << ac_id.id
        end
      end
    end
    AdvisoryCategory.where(advisory_reason_id: params[:id].to_i).where.not(id: ids).destroy_all
    redirect_to "/admin/advisory/review-advisory/#{@advisory.sid}"
  end

  def review_advisory
    @advisory = Advisory.find_by(sid: params[:sid]).decorate

    unless @advisory.advisory_reasons.count > 0
      redirect_to "/admin/advisory/new"
    end

    if @advisory.user_id != @user.id
      inbox = Inbox.where(advisory_id: @advisory.id, sender: @advisory.user_id, recipient: @user.id).first
      inbox.is_read = true
      inbox.save
    end

    @incoordination = User.where(id: @advisory.incoordinate_with).collect{ |u| "#{u.first_name}-#{u.user_department.code}" }.join(', ')
    @recipients = User.where(user_department_id: @advisory.recipients).collect{ |u| "#{u.first_name}-#{u.user_department.code}" }.join(', ')
    @replies = ReplyThread.where(advisory_id: @advisory.id).order(:created_at).decorate
    @reply = ReplyThread.new

    if flash[:notice] == 'Successfully created new advisory.'
      flash[:notice] = nil
    end
  end

  def create_reply
    reply = ReplyThread.new(reply_thread_params)
    user_arr = []
    unless reply.save
      puts "--------#{@advisory.errors.full_messages}"
    else
      advisory = Advisory.find(params[:reply_thread][:advisory_id])
      recipients = Inbox.select('distinct(recipient)')
                    .where(advisory_id: params[:reply_thread][:advisory_id])
                    .collect{ |i| i.recipient }
      sender = Inbox.find_by_advisory_id(params[:reply_thread][:advisory_id]).sender
      user_arr = (recipients + sender.to_s.split('')).map(&:to_i)
      user_arr = user_arr - @user.id.to_s.split('').map(&:to_i)
    end
    User.broadcast_notification('web_notifications_channel',
                                  { title: 'New reply to',
                                    sid: "#{advisory.sid}",
                                    message: "#{advisory.advisory_code}",
                                    ids: user_arr,
                                    action: 'reply'
                                  })
    flash[:notice] = 'Reply sent.'
    redirect_to "/admin/advisory/review-advisory/#{params[:reply_thread][:advisory_sid]}"
  end

  def print
    @advisory = Advisory.find_by(sid: params[:sid]).decorate
    @incoordination = User.where(id: @advisory.incoordinate_with).collect{ |u| "#{u.first_name}-#{u.user_department.code}" }.join(', ')
    render layout: false
  end

  def send_advisory
    advisory = Advisory.find_by(sid: params[:sid])
    unless advisory.blank?
      data_arr = []
      user_arr = []
      advisory.recipients.each do |id|
        User.where(user_department_id: id).each do |user|
          user_arr << user.id
          data_arr << {
            recipient: user.id,
            sender: advisory.user_id,
            advisory_id: advisory.id,
            priority: params[:priority].to_i
          }
        end
        
      end

      # advisory.incoordinate_with.each do |id|
      #   unless user_arr.include?(id.to_i)
      #     user_arr << id.to_i
      #     data_arr << {
      #       recipient: id.to_i,
      #       sender: advisory.user_id,
      #       advisory_id: advisory.id,
      #       priority: params[:priority].to_i
      #     }
      #   end
      # end

      unless @user.user_department_id == 8
        User.where(user_department_id: 8).each do |u|
          unless user_arr.include?(u.id)
            user_arr << u.id
            data_arr << {
              recipient: u.id,
              sender: advisory.user_id,
              advisory_id: advisory.id,
              priority: params[:priority].to_i
            }
          end
        end
      end

      Inbox.create(data_arr)
      User.broadcast_notification('web_notifications_channel',
                                  { title: 'New Advisory',
                                    sid: "#{advisory.sid}",
                                    message: "#{advisory.advisory_code}",
                                    ids: user_arr,
                                    priority: params[:priority].to_i,
                                    date_send: "#{advisory.decorate.date_send}",
                                    action: nil
                                  })
      advisory.update_attributes(is_viewable: true, sent_date: DateTime.now)
      flash[:notice] = 'Message sent.'
      redirect_to "/admin/advisory/review-advisory/#{params[:sid]}"
    end
  end

  def created_filter
    adv = AdvisoryReason.select('distinct(advisory_reasons.advisory_id)').filter_joins
    unless params[:val].blank?
      reason_ids = Reason.by_reason(params[:val]).collect{ |r| r.id }
      remark_ids = Remark.by_remark(params[:val]).collect{ |r| r.id }
      frequency_ids = Frequency.by_frequency(params[:val]).collect{ |f| f.id }
      adv = adv.filter_remark_reason(reason_ids.join(','), remark_ids.join(','), params[:val], frequency_ids.join(','))
    end
    unless params[:flight_date].blank?
      adv = adv.filter_flight_date(params[:flight_date])
    end
    unless params[:ac_registry].blank?
      adv = adv.filter_ac_registry(params[:ac_registry])
    end
    unless params[:flight_number].blank?
      adv = adv.filter_flight_number(params[:flight_number])
    end

    @advisory = Advisory.where(id: adv.collect{ |a| a.advisory.id })
                .where(user_id: @user.id, is_viewable: true).order('created_at desc').decorate
    render partial: 'admin/advisory/created/body'
  end

  def inbox_filter
    adv = AdvisoryReason.select('distinct(advisory_reasons.advisory_id)').filter_joins
    unless params[:val].blank?
      reason_ids = Reason.by_reason(params[:val]).collect{ |r| r.id }
      remark_ids = Remark.by_remark(params[:val]).collect{ |r| r.id }
      frequency_ids = Frequency.by_frequency(params[:val]).collect{ |f| f.id }
      adv = adv.filter_remark_reason(reason_ids.join(','), remark_ids.join(','), params[:val], frequency_ids.join(','))
    end
    unless params[:flight_date].blank?
      adv = adv.filter_flight_date(params[:flight_date])
    end
    unless params[:dept_id].blank?
      adv = adv.filter_department(params[:dept_id])
    end
    unless params[:ac_registry].blank?
      adv = adv.filter_ac_registry(params[:ac_registry])
    end
    unless params[:flight_number].blank?
      adv = adv.filter_flight_number(params[:flight_number])
    end
    unless params[:user_id].blank?
      adv = adv.filter_users(params[:user_id])
    end

    @advisories = Inbox.where(advisory_id: adv.collect{ |a| a.advisory.id })
                        .by_recipient(@user.id)
                        .where.not(sender: @user.id).order('created_at desc').decorate
    render partial: 'inbox_body'
  end

  def forward
    dept_ids = params[:dept_ids]
    advisory = Advisory.find(params[:advisory_id]).decorate
    advisory.recipients = advisory.recipients + dept_ids
    status = :error
    if advisory.save
      data_arr = []
      user_arr = []
      priority = Inbox.where(advisory_id: advisory.id).first.try(:priority)
      dept_ids.each do |id|
        User.where(user_department_id: id.to_i).each do |user|
          user_arr << user.id
          data_arr << {
            recipient: user.id,
            sender: advisory.user_id,
            advisory_id: advisory.id,
            priority: priority || 1
          }
        end
      end

      Inbox.create(data_arr)
      User.broadcast_notification('web_notifications_channel',
                                  { title: 'New Advisory',
                                    sid: "#{advisory.sid}",
                                    message: "#{advisory.advisory_code}",
                                    ids: user_arr,
                                    priority: priority,
                                    date_send: "#{advisory.date_send}",
                                    action: nil
                                  })

      status = :ok
    else
      puts "--------#{advisory.errors.full_messages}"
    end

    render json: status
  end

  def delete_advisory_reason
    @advisory_reason.destroy
    redirect_to "/admin/advisory/review-advisory/#{@advisory.sid}"
  end

  private
    def set_advisory
      @advisory_reason = AdvisoryReason.find(params[:id])
      @advisory = Advisory.find(@advisory_reason.advisory_id)
    end

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
      else
        occ_params
      end
    end

    def advisory_params dept_code
      params[:advisory][:recipients] = params[:advisory][:recipients].reject { |c| c.empty? }
      params[:advisory][:incoordinate_with] = params[:advisory][:incoordinate_with].reject { |c| c.empty? }
      params[:advisory][:advisory_reasons_attributes]["0"][:reasons] = params[:advisory][:advisory_reasons_attributes]["0"][:reasons].to_s.split('') if params[:advisory][:advisory_reasons_attributes]["0"][:reasons].present?
      params[:advisory][:advisory_reasons_attributes]["0"][:remarks] = params[:advisory][:advisory_reasons_attributes]["0"][:remarks].reject { |c| c.empty? } if params[:advisory][:advisory_reasons_attributes]["0"][:remarks].present?

      params.require(:advisory).permit(
        :user_id,
        {:advisory_reasons_attributes => [
          :time_and_date,
          :other_remarks,
          advisory_category_params,
          :reasons => [],
          :remarks => [],
        ]},
        :recipients => [],
        :incoordinate_with => [],
      )
    end

    def add_reason_params
      params[:advisory][:advisory_reasons_attributes]["0"][:reasons] = params[:advisory][:advisory_reasons_attributes]["0"][:reasons].to_s.split('') if params[:advisory][:advisory_reasons_attributes]["0"][:reasons].present?
      params[:advisory][:advisory_reasons_attributes]["0"][:remarks] = params[:advisory][:advisory_reasons_attributes]["0"][:remarks].reject { |c| c.empty? } if params[:advisory][:advisory_reasons_attributes]["0"][:remarks].present?
      params[:advisory][:advisory_reasons_attributes]["0"].permit(
        :time_and_date,
        :other_remarks,
        occ_params,
        :reasons => [],
        :remarks => [],
      )
    end

    def advisory_category_params
      {
        :advisory_categories_attributes => [
          :ac_configuration, :ac_location, :ac_on_ground, :ac_registry, :ac_status_datetime,
          :acu_problem, :air_bourne, :aircraft_type_id, :apu_inoperative, :baggage_cargo_loaded,
          :blocked_in, :cabin_crew_boarded, :category_id, :close_door, :cockpit_crew_boarded, :effective_date,
          :flight_date, :flight_number, :general_boarding, :load_b, :load_e, :load_p,
          :location, :max_wind, :movement, :no_avi, :nsta, :nstd, :push_back, :remarks, :restriction,
          :route_destination, :route_origin, :seat_blocks, :sta, :std, :tow_in, :tow_out, :weather_forecast,
          :arrival_terminal, :departure_terminal, :duration_of_delay, :eta, :etd, :neta, :netd,
          :pax, :touchdown, :frequencies => []
        ]
      }
    end

    def ltp_params
      {:advisory_categories_attributes => [
        :category_id, :effective_date, :ac_registry, :flight_number, :ac_status_datetime, :remarks
      ]}
    end

    def fmd_params
      {:advisory_categories_attributes => [
        :apu_inoperative, :seat_blocks, :no_avi, :restriction,
        :acu_problem, :ac_on_ground, :remarks
      ]}
    end

    def rmd_params
      {:advisory_categories_attributes => [
        :effective_date, :ac_registry, :flight_number, :load_b,
        :load_p, :load_e, :remarks
      ]}
    end

    def csd_params
      {:advisory_categories_attributes => [
        :ac_registry, :aircraft_type_id, :flight_number, :flight_date,
        :remarks
      ]}
    end

    def cfd_params
      {:advisory_categories_attributes => [
        :category_id, :location, :movement, :max_wind,
        :weather_forecast, :ac_registry, :remarks, :route_origin, :route_destination,
        :ac_location, :ac_status_datetime 
      ]}
    end

    def at_params
      {:advisory_categories_attributes => [
        :tow_out, :tow_in, :blocked_in, :ac_registry,
        :cockpit_crew_boarded, :cabin_crew_boarded, :general_boarding,
        :baggage_cargo_loaded, :close_door, :push_back, :touchdown, :air_bourne, :remarks
      ]}
    end

    def sp_params
      {:advisory_categories_attributes => [
        :category_id, :flight_date, :flight_number, :route_origin, :route_destination,
        :ac_registry, :aircraft_type_id, :ac_configuration, :std, :sta, :nstd, :nsta,
        :remarks, :frequencies => []
      ]}
    end

    def occ_params
      {:advisory_categories_attributes => [
        :flight_date, :flight_number, :route_origin,
        :route_destination, :ac_registry, :aircraft_type_id,
        :ac_configuration, :remarks, :pax, :etd, :eta, :netd,
        :neta, :duration_of_delay, :departure_terminal, :arrival_terminal,
        :category_id
      ]}
    end

    def reply_thread_params
      params.require(:reply_thread).permit(:message, :user_id, :advisory_id)
    end
end
