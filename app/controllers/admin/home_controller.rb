class Admin::HomeController < Admin::ApplicationController
  def index
    @memos = Memo.all.order('created_at desc').decorate
    @memo = nil
    @ac_id = nil;
    @dept_id = nil;
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
    render partial: 'memo_info_body'
  end
end
