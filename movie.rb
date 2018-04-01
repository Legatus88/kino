require 'csv'

class Movie

  attr_reader :period, :col, :my_hash, :link, :title, :year, :country, :starting_date, :genre, :time, :rate, :producer, :actors, :period  
 
  def initialize(hash={}, collection)
    @period = self.class.to_s.chomp('Movie').downcase.to_sym
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


#====================================================================================================
class AncientMovie < Movie
  COST = 1

  def show_price
    COST
  end
  
  def description 
    "#{title} - старый фильм(#{year})"
  end
end
#====================================================================================================

class ClassicMovie < Movie
  COST = 1.5

  def initialize(hash={}, collection)
    @col = collection
    super
  end

  def show_price
    COST
  end
  
  def description
    "#{title} — классический фильм, режиссёр #{man = producer}: " + 
      col.select{|line| line[:producer] == man}.map{|line| line[:title]}.first(10).to_s
  end
end
#====================================================================================================

class ModernMovie < Movie
  COST = 3

  def show_price
    COST
  end
  
  def description
    "#{title} - современное кино: #{title}"     
  end
end
#====================================================================================================

class NewMovie < Movie
  COST = 5

  def show_price
    COST
  end
  
  def description
    "#{title} - новинка, вышло #{Time.now.strftime("%Y").to_i - year.to_i} лет назад!)"
  end
end  