class Inbox < ApplicationRecord
  belongs_to :advisory

  scope :by_recipient, -> (value) { where(recipient: value) }
end
