require 'csv'

class Movie
  attr_accessor :col, :my_hash, :link, :title, :year, :country, :starting_date, :genre, :time, :rate, :producer, :actors  
 
  def initialize(hash={}, collection)
    @col = collection
    @my_hash = hash
    @link = hash[:link]
    @title = hash[:title]
    @year = hash[:year].to_i
    @country = hash[:country]
    @starting_date = hash[:starting_date]
    @genre = hash[:genre].split(',')
    @time = hash[:time].to_i
    @rate = hash[:rate].to_f
    @producer = hash[:producer]
    @actors = hash[:actors].split(',')
  end

  def matches?(key, values)
      if key.select {|cell| cell.include?(values.to_s)}.length == 0
        false
      else 
        true
      end
  end


  def has_genre?(param)
    if col[:genre].select {|hash| hash.include?(param)}.length != 0
      genre.include?(param)
    else
      raise 'Sorry, this genre doesn\'t exist'
    end  
  end

end