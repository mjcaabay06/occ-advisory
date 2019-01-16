class AdvisoryDecorator < Draper::Decorator
  delegate_all

  def title
    <<~HEREDOC.squish
      #{advisory_code || "##{id}"}
    HEREDOC
  end

  def date_send
    sent_date.try(:strftime, '%m-%d-%y %H%Mz') || created_at.try(:strftime, '%m-%d-%y %H%Mz')
  end
end
