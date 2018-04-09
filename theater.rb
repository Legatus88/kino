require './movie_collection'

class Theater < MovieCollection
#  8:00 - 12:00 Ancient
# 12:00 - 18:00 Comedy, Adventure
# 18:00 - 23:00 Drama, Horror
  include Cashbox

  TIMETABLE = { ("08:00".."12:00") =>  {period: :ancient}, 
                ("12:00".."18:00") =>  {period: /classic|modern|new/i, genre: /Comedy|Advanture/}, 
                ("18:00".."23:00") =>  {period: /classic|modern|new/i, genre: /Drama|Horror/} }

  def show(time)
    list = filter(TIMETABLE.select {|key, value| key.cover?(Time.parse(time).strftime("%H:%M"))}.values.first)
    random_movie = list.sort_by { |m| m.rate * rand }.last
    print "Now showing: #{random_movie.title} #{Time.at(0).utc.strftime("%H:%M:%S")} - #{Time.at(random_movie.time*60).utc.strftime("%H:%M:%S")}"
  end
   
  def when?(name)
    TIMETABLE.select{|key, value| filter(value).any?{|movie| movie.title == name }}.keys
  end

  def buy_ticket(movie)
    case when?(movie)
    when ["08:00".."12:00"]
      @money += Money.new(300, "USD")
    when ["12:00".."18:00"]
      @money += Money.new(500, "USD")
    when ["18:00".."23:00"]
      @money += Money.new(1000, "USD")
    when []
      raise ArgumentError, "Такого фильма в прокате нет"
    end
    puts "Вы купили билет на #{movie}"
  end
end