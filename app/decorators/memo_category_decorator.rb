class MemoCategoryDecorator < Draper::Decorator
  delegate_all

  def load_bpe
    "B: #{load_b} | P: #{load_p} | E: #{load_e}"
  end

  def aircraft_type
    AircraftType.find(aircraft_type_id).try(:ac_type)
  end

  def frequency
    Frequency.where(id: frequencies).try(:frequency)
  end

  def route
    "#{try(:route_origin)}-#{try(:route_destination)}"
  end
end
