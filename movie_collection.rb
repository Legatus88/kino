require 'csv'
require './movie'

class MovieCollection
  attr_accessor :file 

  def initialize(file_name)
    @file = file_name 
  end  

  def full_list
  	full_list = CSV.read(file, :col_sep => "|", :headers => %i[link title year country starting_date genre time rate producer actors]).map {|row|
    Movie.new(row) }
  end
  
# Выдать список фильмов: all возвращает массив всех фильмов, которые в нём хранятся
  def all 
    full_list
  end

# Выдать сортированный список фильмов, например movies.sort_by(:date) — возвращает массив фильмов, отсортированных по дате выхода (и так для любого поля);
  def sort_by(parameter)
    puts all.sort_by {|hash| hash.send(parameter)}
  end

# выдать фильтрованный список фильмов — по некоторым полям, вроде жанра и страны, например movies.filter(genre: 'Comedy') — возвращает массив фильмов с жанром «Comedy»;
  def filter(hash)
  	key = hash.keys.first.to_sym
  	value = hash.values.first.to_s
  	puts all.select{|single| single.send(key).include?(value)}
  end	

# выдать статистику по запросу: режиссёр, актёр, год, месяц, страна, жанр — например, movies.stats(:director) возвращает хеш «имя режиссёра → количество фильмов»
  def stats(parameter)
    cutted_arr = all.map {|hash| hash.send(parameter)}.sort
    statistics_hash = Hash.new(0)
    final_hash = cutted_arr.each_with_object(statistics_hash) {|year, list| list[year] += 1 }
 	final_hash.each{ |key, value|
 	  puts "#{key} ---> #{value}" }
  end

# Вот такое выражение: has_genre?('Tragedy') (когда такой жанр вообще не существует) — должно бросать исключение. А код в основном файле должен его перехватывать и печатать, что за исключение произошло
  def has_genre?(parameter)
  	final_list = all.map{|hash| hash.genre}.select{|hash| hash.include?(parameter) }.length
  	if final_list == 0 
  	  puts "Genre doesn't exist"
  	  throw :stopProc 
  	else
  	  puts "It exists"
  	end
  end

end