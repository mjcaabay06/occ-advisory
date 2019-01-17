class Admin::AdvisoryController < Admin::ApplicationController
  include AdvisoryConcern

  def index
    @advisory = Advisory.where(user_id: @user.id, is_viewable: true).order('created_at desc').decorate
  end

  def inbox
    @advisories = Inbox.by_recipient(@user.id).order('created_at desc').decorate
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

  def review_advisory
    unless request.env['HTTP_REFERER'].blank?
      session[:last_page] = request.env['HTTP_REFERER']
    end
    @advisory = Advisory.find_by(sid: params[:sid]).decorate
    puts "-----------#{@advisory.user_id} :: #{@user.id}"

    if @advisory.user_id != @user.id
      inbox = Inbox.where(advisory_id: @advisory.id, sender: @advisory.user_id, recipient: @user.id).first
      inbox.is_read = true
      inbox.save
    end

    @incoordination = User.where(id: @advisory.incoordinate_with).collect{ |u| "#{u.first_name}-#{u.user_department.code}" }.join(', ')
    @recipients = User.where(user_department_id: @advisory.recipients).collect{ |u| "#{u.first_name}-#{u.user_department.code}" }.join(', ')
    @replies = ReplyThread.where(advisory_id: @advisory.id).order(:created_at).decorate
    @reply = ReplyThread.new
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

      advisory.incoordinate_with.each do |id|
        unless user_arr.include?(id)
          user_arr << id.to_i
          data_arr << {
            recipient: id.to_i,
            sender: advisory.user_id,
            advisory_id: advisory.id,
            priority: params[:priority].to_i
          }
        end
      end

      unless @user.user_department_id == 8
        User.where(user_department_id: 8).each do |u|
          unless user_arr.include?(u.id)
            user_arr << u.id.to_i
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
      redirect_to '/admin/advisory'
    end
  end

  def created_filter
    adv = AdvisoryReason.select('distinct(advisory_reasons.advisory_id)').filter_joins
    unless params[:val].blank?
      reason_ids = Reason.by_reason(params[:val]).collect{ |r| r.id }
      remark_ids = Remark.by_remark(params[:val]).collect{ |r| r.id }
      adv = adv.filter_remark_reason(reason_ids.join(','), remark_ids.join(','), params[:val])
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
      adv = adv.filter_remark_reason(reason_ids.join(','), remark_ids.join(','), params[:val])
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

    @advisories = Inbox.where(advisory_id: adv.collect{ |a| a.advisory.id })
                        .by_recipient(@user.id).order('created_at desc').decorate
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
      else
        occ_params
      end
    end

    def advisory_params dept_code
      params[:advisory][:recipients] = params[:advisory][:recipients].reject { |c| c.empty? }
      params[:advisory][:incoordinate_with] = params[:advisory][:incoordinate_with].reject { |c| c.empty? }
      params[:advisory][:advisory_reasons_attributes]["0"][:reasons] = params[:advisory][:advisory_reasons_attributes]["0"][:reasons].reject { |c| c.empty? } if params[:advisory][:advisory_reasons_attributes]["0"][:reasons].present?
      params[:advisory][:advisory_reasons_attributes]["0"][:remarks] = params[:advisory][:advisory_reasons_attributes]["0"][:remarks].reject { |c| c.empty? } if params[:advisory][:advisory_reasons_attributes]["0"][:remarks].present?

      params.require(:advisory).permit(
        :user_id,
        {:advisory_reasons_attributes => [
          :time_and_date,
          :other_remarks,
          get_proper_params(dept_code),
          :reasons => [],
          :remarks => [],
        ]},
        :recipients => [],
        :incoordinate_with => [],
      )
    end

    def add_reason_params
      params[:advisory][:advisory_reasons_attributes]["0"][:reasons] = params[:advisory][:advisory_reasons_attributes]["0"][:reasons].reject { |c| c.empty? } if params[:advisory][:advisory_reasons_attributes]["0"][:reasons].present?
      params[:advisory][:advisory_reasons_attributes]["0"][:remarks] = params[:advisory][:advisory_reasons_attributes]["0"][:remarks].reject { |c| c.empty? } if params[:advisory][:advisory_reasons_attributes]["0"][:remarks].present?
      params[:advisory][:advisory_reasons_attributes]["0"].permit(
        :time_and_date,
        :other_remarks,
        occ_params,
        :reasons => [],
        :remarks => [],
      )
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
