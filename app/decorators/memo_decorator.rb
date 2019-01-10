class MemoDecorator < Draper::Decorator
  delegate_all

  def date_send
    sent_date.try(:strftime, '%m-%d-%y %H%Mz') || created_at.try(:strftime, '%m-%d-%y %H%Mz')
  end

  def memo_title
    <<~HEREDOC.squish
      #{memo_code || "##{id}"}
    HEREDOC
  end

  def memo_info
    # <<~HEREDOC.squish
    #   #{self.memo_title} | 
    #   #{aircraft_registry.try(:aircraft_name)}
    # HEREDOC
  end

end
