class CourseController < ApplicationController
  def index
  end

  def search
    @keyword = params['keyword'] || ''
    page = params['page'].to_i || 0

    # @results = Subject.search_by_keyword(params['keyword'])
    results = Subject.find_by_keyword(@keyword)
    
    @page = page + 1
    @count = results.count
    @results_by_page = results.page(page)
  end

  def detail
    code = params['id']
    @result = Subject.detail(code)[0]
  end
end
