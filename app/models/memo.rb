class Memo < ApplicationRecord
  before_validation :set_memo_code

  has_many :memo_categories, dependent: :destroy
  belongs_to :user

  accepts_nested_attributes_for :memo_categories

  scope :by_user, -> (value) { where(user_id: value) }
  scope :memo_filter, -> (value) { joins(:memo_categories).merge(MemoCategory.memo_filter(value)) if value.present? }
  scope :by_flight_date,  -> (value) { memo_filter.merge(MemoCategory.by_flight_date(value)) if value.present? }

  scope :by_recipients, -> (value) { where("'#{value}' = any (recipients)") }
  scope :by_incoordinate_with, -> (value) { where("'#{value}' = any (incoordinate_with)") }
  scope :filter_inbox, -> (value) { by_recipients(value).or(by_incoordinate_with(value)) }

  def self.filter_joins
    query = <<~HEREDOC.squish
      inner join users on users.id = memos.user_id
      inner join memo_categories on memo_categories.memo_id = memos.id
      left join categories on categories.id = memo_categories.category_id
    HEREDOC
    joins(query)
  end

  def self.filter_text value
    query = <<~HEREDOC.squish
      categories.category ilike '%#{value.downcase}%' OR
      memo_categories.ac_registry ilike '%#{value}%' OR
      memo_categories.flight_number ilike '%#{value}%'
    HEREDOC
    where(query) if value.present?
  end

  def self.filter_flight_date value
    where("memo_categories.flight_date = '#{value}'")
  end

  def self.filter_department value
    where("users.user_department_id = #{value}")
  end

  private
    def set_memo_code
      return unless self.new_record?
      self.memo_code = "#{self.user.user_department.code.upcase}#{Date.today.strftime('%m')}/#{(Memo.last.try(:id) || 0) + 1}"
      self.sid = Digest::MD5.hexdigest(self.memo_code)
    end
end
