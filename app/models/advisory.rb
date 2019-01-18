class Advisory < ApplicationRecord
  belongs_to :user
  has_many :advisory_reasons, dependent: :destroy

  accepts_nested_attributes_for :advisory_reasons

  before_validation :set_advisory_code

  private
    def set_advisory_code
      return unless self.new_record?
      return if self.sid.present?
      self.advisory_code = "#{self.user.user_department.code.upcase}-#{Date.today.strftime('%m')}#{(Advisory.last.try(:id) || 0) + 1}"
      self.sid = Digest::MD5.hexdigest(self.advisory_code)
    end
end
