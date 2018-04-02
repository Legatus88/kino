require 'csv'
require './movie'

class ClassicMovie < Movie
  COST = 1.5
  
  def description
    puts "#{title} — классический фильм, режиссёр #{producer}:" 
    col.filter(producer: producer).map(&:title).delete_if{|ti| ti == title}.first(10)
  end
end