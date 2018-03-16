require 'csv'

class Movie
  attr_accessor :my_hash, :link, :title, :year, :country, :starting_date, :genre, :time, :rate, :producer, :actors  
 
  def initialize(hash={})
    @my_hash = hash
    @link = hash[:link]
    @title = hash[:title]
    @year = hash[:year]
    @country = hash[:country]
    @starting_date = hash[:starting_date]
    @genre = hash[:genre]
    @time = hash[:time]
    @rate = hash[:rate]
    @producer = hash[:producer]
    @actors = hash[:actors]	  
  end

  def has_genre?(param)
    genre.include?(param)
  end
end

class MovieCollection
  attr_accessor :file 

  def initialize(file_name)
    @file = file_name 
  end  
  
  def all 
    CSV.read(file, :col_sep => "|", :headers => %i[link title year country starting_date genre time rate producer actors]).map {|row|
    Movie.new(row) }
  end

  def sort_by(parameter)
    all.sort_by{|hash| hash.parameter}
  end
end

movies = MovieCollection.new('movies.txt')

puts movies.send(sort_by(time))
