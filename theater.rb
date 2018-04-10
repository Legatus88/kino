require './movie_collection'

class Theater < MovieCollection
  
  include Cashbox

  TIMETABLE = { ("08:00".."12:00") =>  {period: :ancient}, 
                ("12:00".."18:00") =>  {period: /classic|modern|new/i, genre: /Comedy|Advanture/}, 
                ("18:00".."23:00") =>  {period: /classic|modern|new/i, genre: /Drama|Horror/} }

  TICKETS_PRICE = { ("08:00".."12:00") =>  3, 
                    ("12:00".."18:00") =>  5, 
                    ("18:00".."23:00") =>  10 }

  def show(time)
    list = filter(TIMETABLE.select {|key, value| key.cover?(Time.parse(time).strftime("%H:%M"))}.values.first)
    random_movie = list.sort_by { |m| m.rate * rand }.last
    print "Now showing: #{random_movie.title} #{Time.at(0).utc.strftime("%H:%M:%S")} - #{Time.at(random_movie.time*60).utc.strftime("%H:%M:%S")}"
  end

  
  def when?(name)
    TIMETABLE.select{|key, value| filter(value).any?{|movie| movie.title == name }}.keys
  end

  def buy_ticket(movie)
    add_money(TICKETS_PRICE.select{|key, value| key == when?(movie).first }.values.first * 100)     
  end
end