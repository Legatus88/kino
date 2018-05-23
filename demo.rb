#require './movie_collection'
#require './netflix'
#require './theater'
#require 'csv'
#require './movie'
#require './ancient_movie'
#require './classic_movie'
#require './modern_movie'
#require './new_movie'
#require './genre_selection'
#require './country_selection'
#require 'virtus'
#require 'haml'
#require 'yaml'
#require 'themoviedb-api'
#require 'progress_bar'

#===== Выполнение .has_genre?(param)=====
#begin
#puts oc.all.first.has_genre?("Dawd")
#rescue ArgumentError => e
#  puts e.message 
#end
#========================================

#begin
#puts oc.balance
#oc.pay(5)
#puts oc.balance
#puts oc.show(title: "Pulp Fiction")
#puts oc.balance
#puts oc.show(title: "The Terminator")
#puts oc.balance
#puts Netflix.cash
#oc.pay(15)

#puts Netflix.cash
#rescue ArgumentError => e
#  puts e.message
#end
#puts oc.genre_list.to_s

#oc = Theater.new('movies.txt')
#puts oc.stats(:renree)
#puts mov = MovieCollection.new('movies.txt').filter(period: :classic).first.description

#puts oc.all[4].description
#puts all = oc.all[4].description
#puts oc.show('08:00')


#puts oc.filter(period: :modern).first.description

#oc.define_filter(:new_sci_fi) { |movie, year| movie.title.include?('Inception') && movie.genre.include?('Action') && movie.year == year }
#oc.define_filter(:f1) { |movie, year| !movie.title.include?('Citizen Kane') && movie.genre.include?('Drama') && movie.year == year }
#oc.define_filter(:f2) { |movie, year| !movie.title.include?('Terminator') && movie.genre.include?('Action') && movie.year > year }

#oc.define_filter(:newest_sci_fi, from: :new_sci_fi, arg: 2010)
#oc.pay(300)
#puts oc.show(title: /the mal/i){ |movie| !movie.title.include?('Citizen Kane') && !movie.genre.include?('Action') && movie.year == 1941}#.map(&:title) #&& movie.genre.include?('Action') && movie.year == 2010}

#puts oc.by_country.canada

#======================================================================================
# Наброски альтернативного решения задачи генерации кинотеатра
#      first_movie_list.each do |movie|
#        two_movie_period = starting_time_in_minutes + movie.time

#      end

#      puts filtered_movie_list.length
#      puts first_movie_list.length

#      puts one_movie_period

 #     if one_movie_period <= ending_time_in_minutes
 #       puts "Название: #{random_movie.title}"
 #       puts "Начало: #{Time.at(starting_time_in_minutes*60).utc.strftime("%H:%M")}"
 #       puts
 #     else
 #       random_movie = filtered_movie_list.sample
 #       puts "Название: #{random_movie.title}"
 #       puts "Начало: #{Time.at(starting_time_in_minutes*60).utc.strftime("%H:%M")}"
 #       puts
 #     end

    #end
#======================================================================================

#======================================================================================
# Генерация расписание через ввод данных с консоли:
# Возникли проблемы с вводом фильтров. Инфа получается в виде строк.
# Попытка разделить строку и переназначить класс переменных успехом не увенчался,
# т.к. помимо символов и строк на вход могут идти Range, integer, массивы и т.д.
# Единственное решение проблемы которое было найдено очень объёмное, поэтому можно считать,
# что решение не было найдено.

#  def enter_the_timetable
#    hall :red, title: 'Красный зал', places: 100
#    hall :blue, title: 'Синий зал', places: 50
#    hall :green, title: 'Зелёный зал (deluxe)', places: 12

#    print 'Введите колличество периодов: '
#    period_quantity = gets.chomp
    
#    print "Введите время открытия кинотеатра: "
#    starting_time = gets.chomp
#    starting_time_arr = starting_time.split(':')
#    starting_time_minutes = starting_time_arr.first.to_i*60 + starting_time_arr.last.to_i

#    i = 1
#    while i <= period_quantity.to_i do
#      print "Enter period №#{i} description: "
#      de = gets.chomp
#      print "Enter period №#{i} filters: "
#      fi = gets.chomp
#      print "Enter period №#{i} price: "
#      pr = gets.chomp.to_i
#      print "Enter period №#{i} halls: "
#      ha = gets.chomp.split(', ').map(&:to_sym)
      
#      biggest_movie_length = filter(genre: 'Comedy').map(&:time).sort.last
#      period_ending = starting_time_minutes + biggest_movie_length
#      time_range = Time.at(starting_time_minutes*60).utc.strftime("%H:%M")..Time.at(period_ending*60).utc.strftime("%H:%M")
      
#      period time_range do
#      description de
#      filters fi
#      price pr
#      hall ha
#      end      

#      starting_time_minutes = period_ending
#      i += 1
#    end
#  end
#======================================================================================


#theater =
#  Theater.new('movies.txt') do
#    hall :red, title: 'Красный зал', places: 100
#    hall :blue, title: 'Синий зал', places: 50
#    hall :green, title: 'Зелёный зал (deluxe)', places: 12

#    period '09:00'..'11:00' do
#      description 'Утренний сеанс'
#      filters genre: 'Comedy', year: 1900..1980
#      price 10
#      hall :red, :blue
#    end

#    period '11:00'..'16:00' do
#      description 'Спецпоказ'
#      title 'The Terminator'
#      price 50
#      hall :green
#    end

#    period '16:00'..'20:00' do
#      description 'Вечерний сеанс'
#      filters genre: ['Action', 'Drama'], year: 2007..Time.now.year
#      price 20
#      hall :red, :blue
#    end

#    period '19:00'..'22:00' do
#      description 'Вечерний сеанс для киноманов'
#      filters year: 1900..1945, exclude_country: 'USA'
#      price 30
#      hall :green
#    end
#  end

#begin
#  puts theater.show('11:00')
#rescue ArgumentError
#  puts theater.show(:red, '11:00')
#end




#puts theater.valid?
#puts theater.all.first.genre
#puts theater.all.first.matches?(:year, 1941)
#puts theater.filter(theater.periods.first.period_filters).map(&:time).sort

#puts theater.no_holes?
#theater.generate
#puts theater.print_timetable

#puts Time.at(theater.all.first.time*60).utc.strftime("%H:%M")
#.cover?(Time.at(theater.all.first.time).strftime("%H:%M"))

#puts theater.periods.first.intersect?('other')
#theater.print_timetable
#theater.timetable_generation
#puts theater.no_holes?
#theater.print_timetable
# puts f = theater.periods.first.period_hall
#ti = ("09:00".."11:00")
#a = 126
#arr = ti.to_a.first.split(':')
#minutes = arr.first.to_i*60 + arr.last.to_i + a
#puts x = Time.at(minutes*60).utc.strftime("%H:%M")

require './movie_collection'
require './tmdb_downloader.rb'
require './budget_downloader.rb'
require './render'
require 'dotenv/load'

col = MovieCollection.new('movies.txt')
fm = col.all.first

bud = BudgetDownloader.new(col)
#puts bud.download_for(fm)
#bud.load_all!
#bud.write_to('./budget.yml')

tmdb = TMDBDownloader.new(col)
#puts tmdb.download_title_for(fm)
#puts tmdb.download_poster_for(fm)
#puts tmdb.download_both_for(fm)
puts tmdb.download_for(fm).class
#tmdb.write('./title_and_poster.yml')

#write_haml('./includes/index.html')

