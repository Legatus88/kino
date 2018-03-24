require './movie_collection'
require 'csv'
require './movie'

movies = MovieCollection.new('movies.txt')

#puts movies.all
#puts movies.sort_by(:time)
#puts movies.filter(year: 1980..1981)

puts movies.filter(year: 1980..1999, genre: 'Action', title: /terminator/i, actors: 'Edward Furlong').length
#puts movies.filter(year: 1980..1981, genre: 'War').length

#puts movies.all.first.matches?(genre: 'Drama')
#puts movies.stats(:actors)

#puts movies.all.first.matches?('a', 'b')

#puts movies.all.first.genre
#puts movies.all.first.has_genre?('asdasd')