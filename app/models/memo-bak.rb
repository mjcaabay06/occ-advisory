class Memo < ApplicationRecord
  has_one :load
  belongs_to :user
  belongs_to :aircraft_registry

  accepts_nested_attributes_for :load

  scope :by_ac_r, -> (value) { where(aircraft_registry_id: value) if value.present? }
  scope :by_created, -> (value) { where("memos.created_at::date = '#{value}'") if value.present? }
end
