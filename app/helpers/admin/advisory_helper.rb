module Admin::AdvisoryHelper
  def reply_count adv_id
    rt = ReplyThread.where(advisory_id: adv_id)
    return nil if rt.blank?
    return '(<small><strong>1 Reply</strong></small>)' if rt.count == 1
    "(<small><strong>#{rt.count} Replies</strong></small>)"
  end

  def is_field field
    fields = @user.user_department.advisory_category_fields.map{|a| a.to_i}
    fields.include?(AdvisoryCategory::Fields[field])
  end

  def is_field_format field
    fields = @advisory.user.user_department.advisory_category_fields.map{|a| a.to_i}
    fields.include?(AdvisoryCategory::Fields[field])
  end
  
end
