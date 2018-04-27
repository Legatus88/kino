require './movie_collection'
require './hall'
require './period'

class Theater < MovieCollection
  
  attr_reader :halls, :periods

  # нужно ли ставить file_name по дуфолту или задание предполагает ввод файла из демо?
  def initialize(file_name, &block)
    super
    @halls = []
    @periods = []
    instance_eval &block if block_given?
  end

  include Cashbox

  def period(time_range, &block)
    @periods << Period.new(time_range, &block)
  end

  # почему params работает, а если передать title и places будет АргументЕррор?
  def hall(hall_name, params)
    @halls << Hall.new(hall_name, params)
  end

  def timetable
    @new_timetable = { periods[0].time_range => periods[0].att_arr[1],
                       periods[1].time_range => periods[1].att_arr[1],
                       periods[2].time_range => periods[2].att_arr[1],
                       periods[3].time_range => periods[3].att_arr[1] }
  end

  def ticket_price
    @new_tickets_price = { periods[0].time_range => periods[0].att_arr[2],
                           periods[1].time_range => periods[1].att_arr[2],
                           periods[2].time_range => periods[2].att_arr[2],
                           periods[3].time_range => periods[3].att_arr[2] }
  end

  def show(time)
    timetable
    list = filter(@new_timetable.select {|key, value| key.cover?(Time.parse(time).strftime("%H:%M"))}.values.first)
    random_movie = list.sort_by { |m| m.rate * rand }.last
    print "Now showing: #{random_movie.title} #{Time.at(0).utc.strftime("%H:%M:%S")} - #{Time.at(random_movie.time*60).utc.strftime("%H:%M:%S")}"
  end

  def when?(name)
    @new_timetable.select{|key, value| filter(value).any?{|movie| movie.title == name }}.keys
  end

  def buy_ticket(movie)
    raise NameError, "Такого фильма нет в прокате" if filter(title: movie).empty?
    add_money(@new_tickets_price.select{ |key, value| key == when?(movie).first }.values.first * 100)     
    puts "Вы купили билет на #{movie}"
  end
end