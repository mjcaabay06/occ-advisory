class UserDecorator < Draper::Decorator
  delegate_all

  def department_code
    user_department.code.try(:downcase).gsub(' ', '_')
  end

end
