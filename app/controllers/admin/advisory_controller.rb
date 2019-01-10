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
  end

  def create
    params[:advisory][:user_id] = @user.id

    @advisory = Advisory.new(advisory_params)
    if @advisory.save
      flash[:notice] = 'Successfully created new advisory.'
      redirect_to "/admin/advisory/review-advisory/#{@advisory.sid}"
    else
      flash[:notice] = 'There was a problem in your application. Please check all fields.'
      redirect_to new_admin_advisory_path
    end
  end

  def review_advisory
    @advisory = Advisory.find_by_sid(params[:sid]).decorate
    @category_ids = @advisory.advisory_categories.select('distinct(category_id)').order(:category_id).collect{|mc| mc.category_id}
    @incoordination = User.where(id: @advisory.incoordinate_with).collect{ |u| "#{u.first_name}-#{u.user_department.code}" }.join(', ')
  end

  def send_advisory
    advisory = Advisory.find_by_sid(params[:sid])
    advisory.update_attributes(is_viewable: true, sent_date: DateTime.now)
    redirect_to '/admin/advisory'
  end

  private
    def advisory_params
      params[:advisory][:recipients] = params[:advisory][:recipients].reject { |c| c.empty? }
      params[:advisory][:incoordinate_with] = params[:advisory][:incoordinate_with].reject { |c| c.empty? }
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
