Reason.create!([
  { reason: 'Overbooking', status_id: 1 }
])

Remark.create!([
  { remark: 'APU/ASU/ACU shutdown', status_id: 1 },
  { remark: 'To avoid delay', status_id: 1 },
  { remark: 'Rectification', status_id: 1 },
  { remark: 'Other remarks', status_id: 1 },
])

Category.create!([
  { category: 'Aircraft Downgrade', status_id: 1 },
  { category: 'Aircraft Upgrade', status_id: 1 },
  { category: 'Cancellation', status_id: 1 },
  { category: 'AC Registry Swap', status_id: 1 },
  { category: 'Flight Replacement', status_id: 1 },
  { category: 'Revised Turnaround Flight', status_id: 1 },
  { category: 'Terminal Change', status_id: 1 },
])
