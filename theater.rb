require 'csv'
require './movie'
require 'time'
require 'date'
require './ancient_movie'
require './classic_movie'
require './modern_movie'
require './new_movie'
require './movie_collection'

class Theater < MovieCollection
#  8:00 - 12:00 Ancient
# 12:00 - 18:00 Comedy, Adventure
# 18:00 - 23:00 Drama, Horror
  
  TIMETABLE = { ("08:00".."12:00") =>  {period: :ancient}, 
                ("12:00".."18:00") =>  {period: /classic|modern|new/i, genre: /Comedy|Advanture/}, 
                ("18:00".."23:00") =>  {period: /classic|modern|new/i, genre: /Drama|Horror/} }

  def show(time)
    list = filter(TIMETABLE.select {|key, value| key.cover?(Time.parse(time).strftime("%H:%M"))}.values[0])
    random_movie = list.sort_by { |m| m.rate * rand }[rand(list.length)]
    final_sting = "Now showing: #{random_movie.title} #{Time.at(0).utc.strftime("%H:%M:%S")} - #{Time.at(random_movie.time*60).utc.strftime("%H:%M:%S")}"
  end
   
  def when?(name)
  TIMETABLE.select{|key, value| filter(value).any?{|movie| movie.title === name }}.keys
  end
end