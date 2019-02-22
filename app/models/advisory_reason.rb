class AdvisoryReason < ApplicationRecord
  belongs_to :advisory
  has_many :advisory_categories, dependent: :destroy

  accepts_nested_attributes_for :advisory_categories, update_only: true

  scope :by_reason_arr, -> (value) { where("reasons::int[] && '{#{value}}'::int[]") }
  scope :by_remark_arr, -> (value) { where("remarks::int[] && '{#{value}}'::int[]") }
  scope :by_reason_remark_arr, -> (reason, remark) { by_reason_arr(reason).or(by_remark_arr(remark)) }

  def self.filter_joins
    query = <<~HEREDOC.squish
      inner join advisories on advisories.id = advisory_reasons.advisory_id
      inner join users on users.id = advisories.user_id
      inner join advisory_categories on advisory_categories.advisory_reason_id = advisory_reasons.id
      left join categories on categories.id = advisory_categories.category_id
    HEREDOC
    joins(query)
  end

  def self.filter_remark_reason reason, remark, value, frequencies
    query = <<~HEREDOC.squish
      #{ search_by_reason(reason) } 
      #{ search_by_remark(remark) }
      #{ search_by_frequency(frequencies) }
      #{ search_by_other_remarks(value) } OR
      #{ search_by_category(value) } OR
      #{ search_by_second_remarks(value) } OR
      #{ search_by_route(value) }
    HEREDOC
    where(query)
  end

  def self.filter_flight_date value
    where("advisory_categories.flight_date = '#{value}'")
  end

  def self.filter_department value
    where("users.user_department_id = #{value}")
  end

  def self.filter_ac_registry value
    where("advisory_categories.ac_registry ilike '%#{value}%'")
  end

  def self.filter_flight_number value
    where("advisory_categories.flight_number ilike '%#{value}%'")
  end

  def self.filter_users value
    where("advisories.user_id = #{value}")
  end

  private

    def self.search_by_reason reason
      "advisory_reasons.reasons::int[] && '{#{reason}}'::int[] OR" unless reason.blank?
    end

    def self.search_by_remark remark
      "advisory_reasons.remarks::int[] && '{#{remark}}'::int[] OR" unless remark.blank?
    end

    def self.search_by_frequency frequencies
      "advisory_categories.frequencies::int[] && '{#{frequencies}}'::int[] OR" unless frequencies.blank?
    end

    def self.search_by_category value
      "categories.category ilike '%#{value.downcase}%'"
    end

    def self.search_by_second_remarks value
      "advisory_categories.remarks ilike '%#{value.downcase}%'"
    end

    def self.search_by_route value
      "advisory_categories.route_destination ilike '%#{value.downcase}%' OR advisory_categories.route_origin ilike '%#{value.downcase}%'"
    end

    def self.search_by_other_remarks value
      "advisory_reasons.other_remarks ilike '%#{value.downcase}%'"
    end
end
