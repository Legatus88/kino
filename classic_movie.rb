require 'csv'
require './movie'

class ClassicMovie < Movie
  COST = 1.5
  
  def description
    "#{title} — классический фильм, режиссёр #{man = producer}: " + 
      col.select{|line| line[:producer] == man}.map{|line| line[:title]}.first(10).to_s
  end
end