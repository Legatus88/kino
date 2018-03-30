require './movie_collection'
require 'csv'
require './movie'

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

#puts oc.how_much?(title: "The Terminator")

oc = Theater.new('movies.txt')
#puts oc.show("9am")
puts oc.when?('Rashomon')