require 'csv'
require 'money'

class Movie

  attr_reader :period, :col, :my_hash, :link, :title, :year, :country, :starting_date, :genre, :time, :rate, :producer, :actors, :period  

  def self.create(line, list)
    case line[:year].to_i
    when 1900..1945
      AncientMovie.new(line, list)
    when 1945..1968
      ClassicMovie.new(line, list)
    when 1968..2000
      ModernMovie.new(line, list)
    when 2000..Time.now.year.to_i
      NewMovie.new(line, list) 
    end
  end
  
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

  def period
    self.class.to_s.chomp('Movie').downcase.to_sym
  end

  def matches?(key, value)
    Array(send(key)).any? {|cell| value === cell}
  end

  def has_genre?(param)
    col.genre_list.include?(param) or raise ArgumentError, 'Sorry, this GENRE doesn\'t exist'
    genre.include?(param)
  end

  def price
    self.class::COST
  end
end