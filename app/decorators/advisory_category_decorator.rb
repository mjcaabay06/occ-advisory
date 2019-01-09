class AdvisoryCategoryDecorator < Draper::Decorator
  delegate_all

  def route
    "#{try(:route_origin)}-#{try(:route_destination)}"
  end

  def dep_ter
    "Terminal #{departure_terminal}" unless departure_terminal.blank?
  end

  def arr_ter
    "Terminal #{arrival_terminal}" unless arrival_terminal.blank?
  end
end
