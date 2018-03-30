require 'csv'
require './movie'
require 'time'
require 'date'

class MovieCollection
  attr_accessor :file, :csv_list, :genre_list, :full_list, :ancient, :classic, :modern, :new

  def initialize(file_name)
    @file = file_name
    @csv_list = CSV.read(file, :col_sep => "|", :headers => %i[link title year country starting_date genre time rate producer actors])
    @genre_list = csv_list.flat_map{|row| row[:genre].split(',')}.uniq
    @full_list = csv_list.select {|line| (1940..1945) === line[:year].to_i}.map {|movie| AncientMovie.new(movie, self.genre_list)} +
      csv_list.select {|line| (1945..1968) === line[:year].to_i}.map {|movie| ClassicMovie.new(movie, self.csv_list)} +
      csv_list.select {|line| (1968..2000) === line[:year].to_i}.map {|movie| ModernMovie.new(movie, self.genre_list)} +
      csv_list.select {|line| (2000..Time.now.strftime("%Y").to_i) === line[:year].to_i}.map {|movie| NewMovie.new(movie, self.genre_list)}
  end  

# Выдать список фильмов: all возвращает массив всех фильмов, которые в нём хранятся
  def all 
    @full_list
  end

# Выдать сортированный список фильмов, например movies.sort_by(:date) — возвращает массив фильмов, отсортированных по дате выхода (и так для любого поля);
  def sort_by(parameter)
  	all.sort_by(&parameter)
  end

# выдать фильтрованный список фильмов — по некоторым полям, вроде жанра и страны, например movies.filter(genre: 'Comedy') — возвращает массив фильмов с жанром «Comedy»;
  def filter(parameter)
    parameter.reduce(all){|result, (key, value)|
      result.select{|movie| movie.matches?(key, value)}}
  end

# выдать статистику по запросу: режиссёр, актёр, год, месяц, страна, жанр — например, movies.stats(:director) возвращает хеш «имя режиссёра → количество фильмов»
  def stats(parameter)
    cutted_arr = all.flat_map(&parameter).sort
    cutted_arr.each_with_object(Hash.new(0)) {|value, list| list[value] += 1 }
  end
end

class Netflix < MovieCollection
  @@balance = 0
  
  def balance
    @@balance    
  end

  def pay(coins)
    @@balance += coins
  end

  def show(parameter)
    @@balance -= filter(parameter).map(&:cost)[0]
    @@balance >= 0 or raise ArgumentError, "Balance is empty"
    filter(parameter).select { |movie| 
      puts "Now showing: #{movie.title} #{Time.at(0).utc.strftime("%H:%M:%S")} - #{Time.at(movie.time*60).utc.strftime("%H:%M:%S")}" }       
    
  end

  def how_much?(title)
    filter(title).map(&:cost)
  end
end

class Theater < MovieCollection
#  8:00 - 12:00 Ancient
# 12:00 - 18:00 Comedy, Adventure
# 18:00 - 23:00 Drama, Horror

  attr_accessor :morning, :day, :evening

  def initialize(file_name)
    @morning = (Time.parse('8am').strftime("%H:%M")..Time.parse('12pm').strftime("%H:%M"))     
    @day = (Time.parse('12pm').strftime("%H:%M")..Time.parse('18pm').strftime("%H:%M"))     
    @evening = (Time.parse('18pm').strftime("%H:%M")..Time.parse('23pm').strftime("%H:%M"))     
    super
  end

  def main_hash
    { @morning => filter(period: :ancient), 
      @day => filter(period: /classic|modern|new/i, genre: /Comedy|Advanture/), 
      @evening => filter(period: /classic|modern|new/i, genre: /Drama|Horror/) 
    }    
  end

  def show(time)
    main_hash.select {|key, value| key === Time.parse(time).strftime("%H:%M")}.values.flatten.select{|movie| 
      puts "Now showing: #{movie.title} - #{movie.genre}; #{movie.period}"}
  end
   
  def when?(name)
    main_hash.select{|key, value| value.any?{|movie| movie.title === name }}.keys
  end

end