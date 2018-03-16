require './movie_collection'
require 'csv'
require './movie'

movies = MovieCollection.new('movies.txt')

#puts movies.all
#puts movies.sort_by(:time)
#puts movies.filter(country: 'USA', actors: 'Ellen')
puts movies.stats(:genre)

#puts movies.all.first.genre

#catch :stopProc do
#puts movies.has_genre?('Comedy')
#end
