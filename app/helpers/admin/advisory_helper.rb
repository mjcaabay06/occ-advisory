module Admin::AdvisoryHelper
  def reply_count adv_id
    rt = ReplyThread.where(advisory_id: adv_id)
    return nil if rt.blank?
    return '(<small><strong>1 Reply</strong></small>)' if rt.count == 1
    "(<small><strong>#{rt.count} Replies</strong></small>)"
  end
end
