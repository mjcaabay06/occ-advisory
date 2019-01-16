class Advisory < ApplicationRecord
  before_validation :set_advisory_code

  has_many :advisory_categories, dependent: :destroy
  belongs_to :user
  belongs_to :memo

  accepts_nested_attributes_for :advisory_categories

  scope :is_viewable, -> { where(is_viewable: true) }
  scope :by_user, -> (value) { where(user_id: value) }
  scope :by_memo, -> (value) { where(memo_id: value) }

  def self.filter_joins
    query = <<~HEREDOC.squish
      inner join users on users.id = advisories.user_id
      inner join advisory_categories on advisory_categories.advisory_id = advisories.id
      left join categories on categories.id = advisory_categories.category_id
    HEREDOC
    joins(query)
  end

  def self.filter_text value
    query = <<~HEREDOC.squish
      categories.category ilike '%#{value.downcase}%' OR
      advisory_categories.ac_registry ilike '%#{value}%' OR
      advisory_categories.flight_number ilike '%#{value}%'
    HEREDOC
    where(query) if value.present?
  end

  def self.filter_flight_date value
    where("advisory_categories.flight_date = '#{value}'")
  end

  private
    def set_advisory_code
      return unless self.new_record?
      return if self.sid.present?
      self.advisory_code = "#{self.user.user_department.code.upcase}#{Date.today.strftime('%m')}/#{(Advisory.last.try(:id) || 0) + 1}"
      self.sid = Digest::MD5.hexdigest(self.advisory_code)
    end
end
