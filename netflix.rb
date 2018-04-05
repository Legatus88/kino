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
    if coins < 0 
      raise RuntimeError, "Wrong amount of money"
    end
    @coins = coins 
  end

  def show(parameter)
    list = filter(parameter)
    @coins >= list.first.price or raise ArgumentError, "Need more money"
    @coins -= list.first.price
    random_movie = list.sort_by { |m| m.rate * rand }.last
    print "Now showing: #{random_movie.title} #{Time.at(0).utc.strftime("%H:%M:%S")} - #{Time.at(random_movie.time*60).utc.strftime("%H:%M:%S")}"       
  end

  def how_much?(name)
    filter(title: name).first.price
  end
end