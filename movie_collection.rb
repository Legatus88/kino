require 'csv'
require './movie'

class MovieCollection
  attr_accessor :file 

  def initialize(file_name)
    @file = file_name 
  end  
  
  def all 
    kino = CSV.read(file, :col_sep => "|", :headers => %i[link title year country starting_date genre time rate producer actors]).map {|row|
    Movie.new(row) }
  end

  def sort_by(parameter)
    puts all.sort_by {|hash| hash.send(parameter)}
  end

  def filter(hash)
  	key = hash.keys.first.to_sym
  	value = hash.values.first.to_s
  	puts all.select{|single| single.send(key).include?(value)}
  end	

  def stats(parameter)
    cutted_arr = all.map {|hash| hash.send(parameter)}.sort
    statistics_hash = Hash.new(0)
    final_hash = cutted_arr.each_with_object(statistics_hash) {|year, list| list[year] += 1 }
 	final_hash.each{ |key, value|
 	  puts "#{key} ---> #{value}" }
  end

end