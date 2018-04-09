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
#oc.buy_ticket("Citizen Kane")
#puts oc.cash
#oc.buy_ticket("The Terminator")


#puts oc.how_much?('The Terminator')

#===== Выполнение .has_genre?(param)=====
#begin
#puts oc.all.first.has_genre?("Dawd")
#rescue ArgumentError => e
#  puts e.message 
#end
#========================================

Money.new(100, "USD").format(:symbol => false)
#m = Money.new('123', :gbp) # => #<Money fractional:123 currency:GBP>
#m.format( symbol: m.currency.to_s + ' ') # => "GBP 1.23"

#begin
#puts oc.balance
#oc.pay(5)
#puts oc.balance
#puts oc.show(title: "Pulp Fiction")
#puts oc.balance
#puts oc.show(title: "The Terminator")
#puts oc.balance
#rescue ArgumentError => e
#  puts e.message
#end
#puts oc.genre_list.to_s

#oc = Theater.new('movies.txt')
#puts oc.stats(:renree)
#puts mov = MovieCollection.new('movies.txt').filter(period: :classic).first.description

#puts oc.all[4].description
#puts all = oc.all[4].description
#puts oc.show('08:00')

#puts oc.filter(period: :modern).first.description