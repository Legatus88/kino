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

  def matches?(key, value)
    key.include?(value) || raise 
    rescue 
    value === key
  end

  def has_genre?(param)
    col.flat_map{|hash| hash[:genre].split(',')}.include?(param) || raise
    genre.include?(param)
    rescue
      "Sorry, this genre doesn\'t exist" 
  end
end