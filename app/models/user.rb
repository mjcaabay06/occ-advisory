class User < ApplicationRecord
  belongs_to :user_department
  belongs_to :status
end
