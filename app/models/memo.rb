class Memo < ApplicationRecord
  has_one :load
  accepts_nested_attributes_for :load
end
