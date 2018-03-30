require 'csv'

class Movie
  attr_accessor :col, :my_hash, :link, :title, :year, :country, :starting_date, :genre, :time, :rate, :producer, :actors, :period  
 
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

class AncientMovie < Movie
  attr_accessor :period, :description, :cost

  def initialize(hash={}, collection)
    @cost = 1
    @period = :ancient
    @description = "#{hash[:title]} - старый фильм(#{hash[:year]})"
    super
  end
end

class ClassicMovie < Movie
  attr_accessor :period, :description, :cost

  def initialize(hash={}, collection)
    @col = collection
    @cost = 1.5
    @period = :classic
    @description = "#{hash[:title]} — классический фильм, режиссёр #{man = hash[:producer]}: " + 
      col.select{|line| line[:producer] == man}.map{|line| line[:title]}.first(10).to_s
    super
  end
end

class ModernMovie < Movie
  attr_accessor :period, :description, :cost

  def initialize(hash={}, collection)
    @cost = 3
    @period = :modern
    @description = "#{hash[:title]} - современное кино: #{hash[:actors]}"
    super
  end
end

class NewMovie < Movie
  attr_accessor :period, :description, :cost

  def initialize(hash={}, collection)
    @cost = 5
    @period = :new
    @description = "#{hash[:title]} - новинка, вышло #{Time.now.strftime("%Y").to_i - hash[:year].to_i} лет назад!)"
    super
  end
end  