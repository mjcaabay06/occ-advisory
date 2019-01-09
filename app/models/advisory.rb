class Advisory < ApplicationRecord
  before_validation :set_advisory_code

  has_many :advisory_categories, dependent: :destroy
  belongs_to :user

  accepts_nested_attributes_for :advisory_categories

  private
    def set_advisory_code
      return unless self.new_record?
      self.advisory_code = "#{self.user.user_department.code.upcase}#{Date.today.strftime('%m')}/#{(Advisory.last.try(:id) || 0) + 1}"
      self.sid = Digest::MD5.hexdigest(self.advisory_code)
    end
end
