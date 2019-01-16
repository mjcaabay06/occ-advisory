act = AircraftType.find(1)
act.update_attributes(ac_type: 'Economy Type')
act = AircraftType.find(2)
act.update_attributes(ac_type: 'Business Type')
