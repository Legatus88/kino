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
  
  TIMETABLE = { (Time.parse('08am').strftime("%H:%M")..Time.parse('12pm').strftime("%H:%M")) =>  {period: :ancient}, 
                (Time.parse('12pm').strftime("%H:%M")..Time.parse('18pm').strftime("%H:%M")) =>  {period: /classic|modern|new/i, genre: /Comedy|Advanture/}, 
                (Time.parse('18pm').strftime("%H:%M")..Time.parse('23pm').strftime("%H:%M")) =>  {period: /classic|modern|new/i, genre: /Drama|Horror/} }

  def show(time)
    better_chances_list = better_chances(filter(TIMETABLE.select {|key, value| key === Time.parse(time).strftime("%H:%M")}.values[0]))
    Array(better_chances_list[rand(better_chances_list.length)]).select { |movie| 
      puts "Now showing: #{movie.title} #{Time.at(0).utc.strftime("%H:%M:%S")} - #{Time.at(movie.time*60).utc.strftime("%H:%M:%S")}" }       
  end
   
  def when?(name)
    TIMETABLE.select{|key, value| filter(value).any?{|movie| movie.title === name }}.keys
  end
end