class Admin::AdvisoryController < Admin::ApplicationController
  def index
    @advisory = Advisory.where(user_id: @user.id).order('sent_date desc, created_at desc').decorate
  end

  def inbox
    @memos = Memo.is_viewable.order('sent_date desc, created_at desc').decorate
  end

  def new
    @advisory = Advisory.new
    @advisory.advisory_categories.build
    @memo_id = Memo.find_by_sid(params[:sid]).try(:id)

    unless @memo_id.blank?
      @adv = Advisory.by_user(@user.id)
            .by_memo(@memo_id)
    end
  end

  def create
    params[:advisory][:user_id] = @user.id

    @advisory = Advisory.new(advisory_params)
    if params[:advisory][:adv_sid].present?
      @advisory.sid = params[:advisory][:adv_sid]
      @advisory.advisory_code = params[:advisory][:adv_code]
    end

    if @advisory.save
      flash[:notice] = 'Successfully created new advisory.'
      redirect_to "/admin/advisory/review-advisory/#{@advisory.sid}"
    else
      flash[:notice] = 'There was a problem in your application. Please check all fields.'
      redirect_to new_admin_advisory_path
    end
  end

  def review_advisory
    @advisory = Advisory.where(sid: params[:sid]).order(:created_at).decorate
    # @category_ids = @advisory.advisory_categories.select('distinct(category_id)').order(:category_id).collect{|mc| mc.category_id}
    @incoordination = User.where(id: @advisory.first.incoordinate_with).collect{ |u| "#{u.first_name}-#{u.user_department.code}" }.join(', ')
  end

  def send_advisory
    advisory = Advisory.find_by_sid(params[:sid])
    advisory.update_attributes(is_viewable: true, sent_date: DateTime.now)
    redirect_to '/admin/advisory'
  end

  def created_filter
    adv_ids = Advisory.select('distinct(advisories.id)').filter_joins
    is_adv = false
    unless params[:val].blank?
      adv_ids = adv_ids.filter_text(params[:val])
      is_adv = true
    end
    unless params[:flight_date].blank?
      adv_ids = adv_ids.filter_flight_date(params[:flight_date])
      is_adv = true
    end

    @advisory = Advisory.where(user_id: @user.id)
    if is_adv
      @advisory = @advisory.where(id: adv_ids)
    end

    @advisory = @advisory.order('sent_date desc, created_at desc').decorate
    render partial: 'admin/advisory/created/body'
  end

  private
    def advisory_params
      params[:advisory][:recipients] = params[:advisory][:recipients].try(:reject) { |c| c.empty? }
      params[:advisory][:incoordinate_with] = params[:advisory][:incoordinate_with].try(:reject) { |c| c.empty? }
      params[:advisory][:reasons] = params[:advisory][:reasons].reject { |c| c.empty? } if params[:advisory][:reasons].present?
      params[:advisory][:remarks] = params[:advisory][:remarks].reject { |c| c.empty? } if params[:advisory][:remarks].present?

      params.require(:advisory).permit(
          :user_id,
          :memo_id,
          {:advisory_categories_attributes => [
            :flight_date, :flight_number, :route_origin,
            :route_destination, :ac_registry, :aircraft_type_id,
            :ac_configuration, :remarks, :pax, :etd, :eta, :netd,
            :neta, :duration_of_delay, :departure_terminal, :arrival_terminal,
            :category_id
          ]},
          :recipients => [],
          :incoordinate_with => [],
          :reasons => [], 
          :remarks => [],
        )
    end
end
