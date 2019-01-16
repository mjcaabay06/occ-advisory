class ReplyThreadDecorator < Draper::Decorator
  delegate_all

  def sender
    u = User.find(user_id)
    unless u.blank?
      "#{u.first_name} [#{u.user_department.code.upcase}]"
    end
  end
end