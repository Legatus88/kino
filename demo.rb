require './movie_collection'
require './netflix'
require './theater'
require 'csv'
require './movie'
require './ancient_movie'
require './classic_movie'
require './modern_movie'
require './new_movie'


#movies = MovieCollection.new('movies.txt')

#oc = Netflix.new('movies.txt')

#begin
#oc.pay(5)
#puts oc.balance
#puts oc.show(title: "Pulp Fiction")
#puts oc.balance
#puts oc.show(title: "The Terminator")
#puts oc.balance
#rescue ArgumentError => e
#  puts e.message
#end

oc = Theater.new('movies.txt')

#puts oc.how_much?('The Terminator')
#puts oc.show('8am')
#puts oc.when?('Rashomon')