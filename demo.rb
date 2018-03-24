require './movie_collection'
require 'csv'
require './movie'

movies = MovieCollection.new('movies.txt')

#puts movies.all
#puts movies.sort_by(:time)
puts movies.filter(year: 1980..1999, genre: 'Action', title: /terminator/i, actors: 'Edward Furlong').length
#puts movies.stats(:actors)
#puts movies.all.first.has_genre?('asdasd')