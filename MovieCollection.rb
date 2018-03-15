require 'csv'
require 'ostruct'

class MovieCollection
  attr_accessor :file

  def initialize(file_name = 'movies.txt')
    @file = file_name
  end  
  
  def full_list
    CSV.read(file, :col_sep => "|", :headers => %i[link title year country starting_date genre time rate producer actors]).map {|row|
    OpenStruct.new(row.to_h) }
  end

  def nice_view(inner_def)
  	inner_def.each do |hash|
      puts "#{hash.title} (#{hash.starting_date}; #{hash.genre}) - #{hash.time}"		
    end
  end

  def all 
#  	puts full_list
	nice_view(full_list)
  end

  def sort_by(param)
  	if param == :time 
      nice_view(full_list.sort_by {|hash| hash[:time].to_i})
  	else
      nice_view(full_list.sort_by(&param))
  	end
  end

  def filter(parameter)
  	parameter = parameter.to_a.flatten     
    nice_view(full_list.select {|hash| hash[parameter[0].to_sym].include?(parameter[1].to_s)})
  end

  def stats(parameter)
  	parameter = parameter.to_a.flatten     
    value = full_list.select {|hash| hash[parameter[0].to_sym].include?(parameter[1].to_s)}.length
  	puts "#{parameter[1]} => #{value} фильмов"
  end

end

#movies = MovieCollection.new('movies.txt')

#movies.all
#movies.sort_by(:time)
#movies.filter(genre: 'Comedy')
#movies.stats(country: 'France')