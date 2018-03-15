require 'csv'
require 'ostruct'

class Movie

  attr_accessor :file
    
  def initialize(file_name = 'movies.txt')
    @file = file_name
  end

  def nice_view(inner_def)
  	inner_def.each do |hash|
      puts "#{hash.title} (#{hash.starting_date}; #{hash.genre}) - #{hash.time}"		
    end
  end

  def all 
	CSV.read(file, :col_sep => "|", :headers => %i[link title year country starting_date genre time rate producer actors]).map {|row|
    OpenStruct.new(row.to_h) }
 	
  end

  def link
  	select(&:link)  	
  end
  def title
  	select(&:title)
  end
  def year
  	select(&:year)
  end
  def country
  	select(&:country)
  end
  def starting_date
  	select(&:starting_date)
  end
  def genre
  	select(&:genre)
  end
  def time
    select(&:time)
  end
  def rate
   select(&:rate)
  end
  def producer
  	select(&:producer)
  end
  def actors
  	select(&:actors)
  end

  def question(value)
  	all.each do |hash| include?(value) end
  end

end


movies = Movie.new

movies.question('Comedy')