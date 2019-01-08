class Category < ApplicationRecord
  belongs_to :status

  scope :by_category, -> (value) { where("category ilike '%#{value.downcase}%'") if value.present? }
end
