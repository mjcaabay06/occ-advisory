class MemoDecorator < Draper::Decorator
  delegate_all

  def date_send
    created_at.strftime('%m/%d/%Y %H:%M')
  end

  def memo_title
    <<~HEREDOC.squish
      ##{id} | 
      #{user.try(:user_department).try(:code)} | 
      #{aircraft_registry.try(:aircraft_name)}
    HEREDOC
  end

end
