require 'csv'

class MyError < StandardError
end

class Movie
  attr_accessor :my_hash, :link, :title, :year, :country, :starting_date, :genre, :time, :rate, :producer, :actors  
 
  def initialize(hash={})
    @my_hash = hash
    @link = hash[:link]
    @title = hash[:title]
    @year = hash[:year]
    @country = hash[:country]
    @starting_date = hash[:starting_date]
    @genre = hash[:genre].split(',')
    @time = hash[:time].to_i
    @rate = hash[:rate]
    @producer = hash[:producer]
    @actors = hash[:actors]	  
  end

  def has_genre?(param)
    if genre.include?(param) == false
      raise MyError, 'It doesn\'t exist'
    else
      true
    end
  end

end