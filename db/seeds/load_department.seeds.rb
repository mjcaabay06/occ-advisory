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
#   { description: 'SP', status_id: 1, code: 'SP' },
# ])

User.create!([
  # { email: 'mj_caabay@yahoo.com', password_digest: Digest::MD5.hexdigest('test000'), first_name: 'marc', last_name: 'caabay', user_department_id: 1, status_id: 1 },
  { email: 'test_ltp', password_digest: Digest::MD5.hexdigest('test000'), first_name: 'Test', last_name: 'LTP', user_department_id: 2, status_id: 1 },
  { email: 'test_fmd', password_digest: Digest::MD5.hexdigest('test000'), first_name: 'Test', last_name: 'FMD', user_department_id: 3, status_id: 1 },
  { email: 'test_rmd', password_digest: Digest::MD5.hexdigest('test000'), first_name: 'Test', last_name: 'RMD', user_department_id: 4, status_id: 1 },
  { email: 'test_csd', password_digest: Digest::MD5.hexdigest('test000'), first_name: 'Test', last_name: 'CSD', user_department_id: 5, status_id: 1 },
  { email: 'test_cfd', password_digest: Digest::MD5.hexdigest('test000'), first_name: 'Test', last_name: 'CFD', user_department_id: 6, status_id: 1 },
  { email: 'test_at', password_digest: Digest::MD5.hexdigest('test000'), first_name: 'Test', last_name: 'AT', user_department_id: 7, status_id: 1 },
  { email: 'test_occ', password_digest: Digest::MD5.hexdigest('test000'), first_name: 'Test', last_name: 'OCC', user_department_id: 8, status_id: 1 },
  { email: 'test_sp', password_digest: Digest::MD5.hexdigest('test000'), first_name: 'Test', last_name: 'SP', user_department_id: 9, status_id: 1 },
])

# AircraftRegistry.create!([
#   { aircraft_name: 'RP-C7779', },
#   { aircraft_name: 'RP-C3501', },
#   { aircraft_name: 'RP-C3437', },
#   { aircraft_name: 'RP-C8784', },
#   { aircraft_name: 'RP-C9902', },
# ])
