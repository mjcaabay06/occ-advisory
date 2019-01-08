class Memo < ApplicationRecord
  has_many :memo_categories, dependent: :destroy

  accepts_nested_attributes_for :memo_categories
end
