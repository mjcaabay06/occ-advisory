Reason.create!([
  { reason: 'Operational Requirements', status_id: 1 },
  { reason: 'Maintenance Requirements', status_id: 1 },
  { reason: 'Weather', status_id: 1 },
  { reason: 'Cancel', status_id: 1 },
  { reason: 'Delay', status_id: 1 },
  { reason: 'Overbooking', status_id: 1 }
])

Remark.create!([
  { remark: 'Weather Delay', status_id: 1 },
  { remark: 'Accident Delay', status_id: 1 },
  { remark: 'Incident Delay', status_id: 1 },
  { remark: 'Operational Delay', status_id: 1 },
  { remark: 'Gatehold Delay', status_id: 1 },
  { remark: 'Taxi Out Delay', status_id: 1 },
  { remark: 'Taxi In Delay', status_id: 1 },
  { remark: 'Taxiway Delay', status_id: 1 },
  { remark: 'Runway Incursion', status_id: 1 },
  { remark: 'Runway Excursion', status_id: 1 },
  { remark: 'Runway Overrun', status_id: 1 },
  { remark: 'Environment Delay', status_id: 1 },
  { remark: 'Earthquake Delay', status_id: 1 },
  { remark: 'Typhoon Delay', status_id: 1 },
  { remark: 'Flight Operation Update', status_id: 1 },
  { remark: 'AC Flight Sched Dom', status_id: 1 },
  { remark: 'AC Flight Sched Int', status_id: 1 },
  { remark: 'Advice to utilize', status_id: 1 },
  { remark: 'Advice to change timings', status_id: 1 },
  { remark: 'Operation for winter or summer', status_id: 1 },
  { remark: 'Advice to be reinstated', status_id: 1 },
  { remark: 'Advise to redesignated', status_id: 1 },
  { remark: 'Advice to implement aircraft switching', status_id: 1 },
  { remark: 'Advice to change configuration', status_id: 1 },
  { remark: 'Advise to change equipment', status_id: 1 },
  { remark: 'Flights will not operate', status_id: 1 },
  { remark: 'Flights will operate', status_id: 1 },
  { remark: 'APU/ASU/ACU inoperative', status_id: 1 },
  { remark: 'Awaiting replacement parts', status_id: 1 },
  { remark: 'Cabin Crew Rest Requirement', status_id: 1 },
  { remark: 'APU/ASU/ACU shutdown', status_id: 1 },
  { remark: 'To avoid delay', status_id: 1 },
  { remark: 'Rectification', status_id: 1 },
  { remark: 'Other remarks', status_id: 1 },
])

Category.create!([
  { category: 'Weather Update', status_id: 1 },
  { category: 'Aircraft Status Update', status_id: 1 },
  { category: 'Other Regards', status_id: 1 },
  { category: 'AC Flight Assignment', status_id: 1 },
  { category: 'AC Status', status_id: 1 },
  { category: 'Original Flight', status_id: 1 },
  { category: 'Aircraft Change-equipment change', status_id: 1 },
  { category: 'Flight Utility', status_id: 1 },
  { category: 'Aircraft Change-configuration change', status_id: 1 },
  { category: 'New Flight', status_id: 1 },
  { category: 'Change Timings', status_id: 1 },
  { category: 'Re-numbering', status_id: 1 },
  { category: 'Aircraft Downgrade', status_id: 1 },
  { category: 'Aircraft Upgrade', status_id: 1 },
  { category: 'Cancellation', status_id: 1 },
  { category: 'AC Registry Swap', status_id: 1 },
  { category: 'Flight Replacement', status_id: 1 },
  { category: 'Revised Turnaround Flight', status_id: 1 },
  { category: 'Terminal Change', status_id: 1 },
])

Location.create!([
  { location: 'North', status_id: 1 },
  { location: 'South', status_id: 1},
  { location: 'East', status_id: 1 },
  { location: 'West', status_id: 1 },
  { location: 'Northeast', status_id: 1 },
  { location: 'Nortwest', status_id: 1 },
  { location: 'Southeast', status_id: 1 },
  { location: 'Southwest', status_id: 1 },
])

AircraftType.create!([
  { ac_type: 'Int Aircraft', status_id: 1 },
  { ac_type: 'Dom Aircraft', status_id: 1 },
])

Frequency.create!([
  { frequency: 'Monday', status_id: 1 },
  { frequency: 'Tuesday', status_id: 1 },
  { frequency: 'Wednesday', status_id: 1 },
  { frequency: 'Thursday', status_id: 1 },
  { frequency: 'Friday', status_id: 1 },
  { frequency: 'Saturday', status_id: 1 },
  { frequency: 'Sunday', status_id: 1 },
])
