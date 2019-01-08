class MemoCategory < ApplicationRecord
  belongs_to :memo
  belongs_to :category

  scope :by_category, -> (value) { joins('LEFT JOIN "categories" ON "categories"."id" = "memo_categories"."category_id"').merge(Category.by_category(value)) }
  scope :by_ac_registry, -> (value) { where("ac_registry ilike '%#{value}%'") }
  scope :by_flight_number, -> (value) { where("flight_number ilike '%#{value}%'") }
  scope :by_flight_date, -> (value) { where("flight_date = '#{value}'") if value.present? }
  scope :memo_filter, lambda { |value| by_category(value).or(by_ac_registry(value)).or(by_flight_number(value)) if value.present? }
end
