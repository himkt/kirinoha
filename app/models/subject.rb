class Subject < ActiveRecord::Base
  include SearchCop

  search_scope :search do
    attributes :code, :title, :terms, :instructors, :daytimes, :info, :condition, :credits, :ca, :grades, :location, :alternative

    options :code => :fulltext
    options :title => :fulltext
    options :terms => :fulltext
    options :instructors => :fulltext
    options :daytimes => :fulltext
    options :info => :fulltext
    options :condition => :fulltext
    options :alternative => :fulltext
    options :grades => :fulltext
    options :location => :fulltext
  end
end
