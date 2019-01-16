class ReplyThread < ApplicationRecord
  belongs_to :user
  belongs_to :advisory
end
