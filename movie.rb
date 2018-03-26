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
    Array(send(key)).any? {|cell| value === cell}
  end

  def has_genre?(param)
    col.include?(param) or raise ArgumentError, 'Sorry, this GENRE doesn\'t exist'
    genre.include?(param)
  end
end

#можно как нибудь получить переменную объекта через переданный ключ? у меня получается только получить значение, 
#но его ещё нужно отсплитить или привести к интеджеру