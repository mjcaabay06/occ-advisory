class Reason < ApplicationRecord
  belongs_to :status

  scope :by_reason, -> (value) { where("reason ilike '%#{value}%'") }
end
