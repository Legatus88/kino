require './movie_collection'
require 'csv'
require './movie'

#movies = MovieCollection.new('movies.txt')

oc = Netflix.new('movies.txt')

begin
oc.pay(5)
puts oc.balance
puts oc.show(title: "Pulp Fiction")
puts oc.balance
puts oc.show(title: "The Terminator")
puts oc.balance
rescue ArgumentError => e
  puts e.message
end
#oc = Theater.new('movies.txt')

#puts oc.how_much?('The Terminator')
#puts oc.show("08am")
#puts oc.when?('Rashomon')