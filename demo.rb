require './movie_collection'
require 'csv'
require './movie'

movies = MovieCollection.new('movies.txt')

#puts movies.all
#movies.sort_by(:time)
#movies.filter(genre: 'Comedy')
#movies.stats(:genre)

#puts movies.all.first.actors
#puts movies.all.first.has_genre?('comedy')
