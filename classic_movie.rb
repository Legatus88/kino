require 'csv'
require './movie'

class ClassicMovie < Movie
  COST = Money.new(150, 'USD')
  def description
    "#{title} — классический фильм, режиссёр #{producer}: (ещё #{col.filter(producer: producer).length} фильмов в топе)"
  end
end