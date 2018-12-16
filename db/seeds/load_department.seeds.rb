# Status.create!([
#   { description: 'Active' },
#   { description: 'Inactive' },
# ])

# UserDepartment.create!([
#   { description: 'Admin', status_id: 1, code: 'Admin' },
#   { description: 'Lufthansa Teknik Philippines', status_id: 1, code: 'LTP' },
#   { description: 'Fleet Maintenance Management Division', status_id: 1, code: 'FMD' },
#   { description: 'Revenue Management Department', status_id: 1, code: 'RMD' },
#   { description: 'Cabin Crew Scheduling Department', status_id: 1, code: 'CSD' },
#   { description: 'Central Flight Dispatch', status_id: 1, code: 'CFD' },
#   { description: 'Airport Terminal', status_id: 1, code: 'Airport Terminal' },
#   { description: 'OCC', status_id: 1, code: 'OCC' },
# ])

# User.create!([
#   { email: 'mj_caabay@yahoo.com', password_digest: Digest::MD5.hexdigest('test000'), first_name: 'marc', last_name: 'caabay', user_department_id: 1, status_id: 1 }
# ])

# AircraftRegistry.create!([
#   { aircraft_name: 'RP-C7779', },
#   { aircraft_name: 'RP-C3501', },
#   { aircraft_name: 'RP-C3437', },
#   { aircraft_name: 'RP-C8784', },
#   { aircraft_name: 'RP-C9902', },
# ])

Flight.create!([
  { aircraft_registry_id: 1, flight_number: '288/289', flight_date: '2018-12-24' },
  { aircraft_registry_id: 1, flight_number: '290/291', flight_date: '2019-01-24' },
  { aircraft_registry_id: 2, flight_number: '292/293', flight_date: '2018-12-24' },
  { aircraft_registry_id: 2, flight_number: '294/295', flight_date: '2019-01-24' },
  { aircraft_registry_id: 3, flight_number: '296/297', flight_date: '2018-12-25' },
  { aircraft_registry_id: 3, flight_number: '298/299', flight_date: '2019-01-25' },
  { aircraft_registry_id: 4, flight_number: '300/301', flight_date: '2018-12-25' },
  { aircraft_registry_id: 4, flight_number: '302/303', flight_date: '2019-01-25' },
  { aircraft_registry_id: 5, flight_number: '304/305', flight_date: '2018-12-26' },
  { aircraft_registry_id: 5, flight_number: '306/307', flight_date: '2019-01-26' },
])
