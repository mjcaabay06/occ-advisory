module ApplicationConcern
  extend ActiveSupport::Concern

  included do
    def check_head_access_url dept_id
      return 'advisory' if [8].include?(dept_id)
      'memo'
    end
  end
end
