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

oc = Netflix.new('movies.txt')
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

#@hash[name] = block if from.nil?
#raise ArgumentError, "Такого фильтра не существует" if @hash[from].nil?
#@hash[name] = ->(movie) { @hash[from].call(movie, arg) }


#oc = Theater.new("movies.txt")
#oc.buy_ticket("Citizen Kane")
#puts oc.when?("Citizen Kane")
#oc.buy_ticket("Citizen Kane")

#puts oc.cash.class
#oc.buy_ticket("Citizen Kane")
#oc.buy_ticket("Citizen Kane")
#oc.buy_ticket("Citizen Kane")
#puts oc.cash
#oc.take("Bank")
#puts oc.format_cash

#puts oc.money
#oc.pay(20)
#puts oc.balance
#puts Netflix.cash
#oc.take("awdawd")

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
#puts Netflix.cash
#oc.pay(15)

#puts Netflix.cash
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

oc.define_filter(:new_sci_fi) { |movie, year| movie.title.include?('Inception') && movie.genre.include?('Action') && movie.year == year }
oc.define_filter(:f1) { |movie, year| !movie.title.include?('Citizen Kane') && movie.genre.include?('Drama') && movie.year == year }
oc.define_filter(:f2) { |movie, year| !movie.title.include?('Terminator') && movie.genre.include?('Action') && movie.year > year }

oc.define_filter(:newest_sci_fi, from: :new_sci_fi, arg: 2010)
oc.pay(300)
puts oc.show(title: /the mal/i){ |movie| !movie.title.include?('Citizen Kane') && !movie.genre.include?('Action') && movie.year == 1941}#.map(&:title) #&& movie.genre.include?('Action') && movie.year == 2010}
