require 'csv'
require './movie'
require 'time'
require 'date'
require './ancient_movie'
require './classic_movie'
require './modern_movie'
require './new_movie'
require './movie_collection'

class Netflix < MovieCollection

  def balance
    @coins
  end

  def pay(coins)
    @coins = coins
  end

  def show(parameter)
    list = filter(parameter)
    @coins >= list[0].price or raise ArgumentError, "Need more money"
    @coins -= list[0].price
    better_chances_list = better_chances(list)
    Array(better_chances_list[rand(better_chances_list.length)]).select { |movie| 
      puts "Now showing: #{movie.title} #{Time.at(0).utc.strftime("%H:%M:%S")} - #{Time.at(movie.time*60).utc.strftime("%H:%M:%S")}" }       
  end

  def how_much?(name)
    filter(title: name)[0].price
  end
end