require './movie_collection'
require 'csv'
require './movie'

movies = MovieCollection.new('movies.txt')

#puts movies.all
#puts movies.sort_by(:time)
puts movies.filter(year: 1980..1985, genre: /War|Action/, title: /terminator/i, actors: 'Linda Hamilton')
#puts movies.stats(:actors)


#begin
#puts movies.all.first.has_genre?('War')
#rescue ArgumentError => e
#  puts e.message
#end