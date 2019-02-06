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

  def load_bpe
    "B: #{load_b} | P: #{load_p} | E: #{load_e}"
  end

  def aircraft_type
    AircraftType.find(aircraft_type_id).try(:ac_type)
  end

  def frequency
    # Frequency.where(id: frequencies).try(:frequency)
    (Frequency.where(id: frequencies).collect{|f| f.frequency }).join(', ')
  end

  def route
    "#{try(:route_origin)}-#{try(:route_destination)}"
  end
end
