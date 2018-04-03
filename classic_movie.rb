require 'csv'
require './movie'

class ClassicMovie < Movie
  COST = 1.5
  
  def description
    "#{title} — классический фильм, режиссёр #{producer}: (ещё #{col.filter(producer: producer).length} фильмов в топе)"
  end
end