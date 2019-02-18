class Frequency < ApplicationRecord
  belongs_to :status

  scope :by_frequency, -> (value) { where("frequency ilike '%#{value}%'") }
end
