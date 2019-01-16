class SearchQueryService
  attr_reader :options, :where_clause
  def initialize(options = {})
    @where_clause = ''
    return search_query
  end

  def search_query
    
  end
end
