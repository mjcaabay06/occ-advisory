class Remark < ApplicationRecord
  belongs_to :status

  scope :by_remark, -> (value) { where("remark ilike '%#{value}%'") }
end
