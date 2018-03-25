require './movie_collection'
require 'csv'
require './movie'

movies = MovieCollection.new('movies.txt')

#puts movies.all
#puts movies.sort_by(:time)
puts movies.filter(year: 1980..1994, genre: /War|Action/, title: /termin/i, actors: 'Linda Hamilton').length
#puts movies.stats(:actors)

#begin
#puts movies.all.first.has_genre?('War')
#rescue
#  "Sorry, this genre doesn\'t exist" 
#end