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

  def hall(hall_name, params)
    @halls << Hall.new(hall_name, params)
  end

  def show(time)
    timetable
    list = filter(@periods.select{|period| period.time_range.cover?(Time.parse(time).strftime("%H:%M"))}.first.period_filters)
    random_movie = list.sort_by { |m| m.rate * rand }.last
    print "Now showing: #{random_movie.title} #{Time.at(0).utc.strftime("%H:%M:%S")} - #{Time.at(random_movie.time*60).utc.strftime("%H:%M:%S")}"
  end

  def when?(name)
    @periods.select{|period| filter(period.period_filters).any?{|movie| movie.title == name }}.first.time_range
  end

  def buy_ticket(movie)
    raise NameError, "Такого фильма нет в прокате" if filter(title: movie).empty?
    add_money(@periods.select{|period| period.time_range == when?(movie)}.first.period_price * 100)  
    puts "Вы купили билет на #{movie}"
  end
end