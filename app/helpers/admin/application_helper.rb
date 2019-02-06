module Admin::ApplicationHelper
  def check_value value
    value.try(:delete, ' ').blank? ? 'N/A' : value
  end
end
