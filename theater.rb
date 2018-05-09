require './movie_collection'
require './hall'
require './period'

class Theater < MovieCollection

  attr_reader :halls, :periods

  def initialize(file_name, &block)
    super
    @halls = []
    @periods = []
    instance_eval &block if block_given?
    raise 'Расписание не корректно' if !self.valid?
    raise 'В расписании есть дыры' if !self.no_holes?
  end

  include Cashbox

  def period(time_range, &block)
    @periods << Period.new(time_range, &block)
  end

  def hall(hall_name, params)
    @halls << Hall.new(hall_name, params)
  end

  def show(time)
    period_list = @periods.select{|period| period.time_range.cover?(Time.parse(time).strftime("%H:%M"))}
    raise 'В это время нет показов' if period_list.empty?
    if period_list.length > 1
      print 'MORE THEN ONE HALL FOUND'
      puts
      print 'Enter the hall: '
      wanted_hall = gets.chomp
      period_list = period_list.select{|period| period.period_hall.include?(wanted_hall.to_sym)}  
    end
    list = filter(period_list.first.period_filters)
    random_movie = list.sort_by { |m| m.rate * rand }.last
    print "Now showing: #{random_movie.title} #{Time.at(0).utc.strftime("%H:%M:%S")} - #{Time.at(random_movie.time*60).utc.strftime("%H:%M:%S")}"
  end

  def when?(name)
    raise 'Такого фильма нет в прокате' if filter(title: name).empty?
    @periods.select{|period| filter(period.period_filters).any?{|movie| movie.title == name }}.first.time_range
  end

  def buy_ticket(movie)
    raise NameError, "Такого фильма нет в прокате" if filter(title: movie).empty?
    add_money(@periods.select{|period| period.time_range == when?(movie)}.first.period_price * 100)  
    puts "Вы купили билет на #{movie}"
  end

  def valid?
    couples = periods.combination(2)
    couples.none?{|fir, sec| sec.intersect?(fir) && (fir.period_hall & sec.period_hall).any?}
  end

# печать расписания:
  def print_timetable
    @periods.each do |period| 
      period.print_period
      puts
    end
  end

  def generate
    @periods.each do |period|
      starting_time = period.time_range.to_a.first
      starting_time_in_minutes = starting_time.split(':').first.to_i*60 + starting_time.split(':').last.to_i
      
      ending_time = period.time_range.to_a.last
      ending_time_in_minutes = ending_time.split(':').first.to_i*60 + ending_time.split(':').last.to_i

      filtered_movie_list = filter(period.period_filters)
      first_movie_list = []
      
      filtered_movie_list.each do |movie|
        one_movie_period = starting_time_in_minutes + movie.time 
        if one_movie_period <= ending_time_in_minutes
          first_movie_list << movie
        end
      end
      
      puts "==========================="
      puts period.period_description
      puts "==========================="
      puts

      while starting_time_in_minutes <= ending_time_in_minutes
        random_movie = first_movie_list.sample
        starting_time_in_minutes += random_movie.time
        if starting_time_in_minutes <= ending_time_in_minutes 
          puts "Название: #{random_movie.title}"
          puts "Начало: #{Time.at(starting_time_in_minutes*60).utc.strftime("%H:%M")}"
          puts
        end
      end
    end
  end


# Генерация расписания через метод:
  def timetable_generation
    hall :red, title: 'Красный зал', places: 100
    hall :blue, title: 'Синий зал', places: 50
    hall :green, title: 'Зелёный зал (deluxe)', places: 12    

    de = ['Утренний сеанс', 'Спецпоказ', 'Вечерний сеанс', 'Вечерний сеанс для киноманов']
    fi = [{genre: 'Comedy', year: 1900..1980}, {title: 'The Terminator'}, {genre: ['Action', 'Drama'], year: 2007..Time.now.year}, {year: 1900..1945, exclude_country: 'USA'}]
    pr = [10, 50, 20, 30]
    ha = [[:red, :blue], :green, [:red, :blue], :green]
    t_r = []

    starting_time = '09:00'
    starting_time_arr = starting_time.split(':')
    starting_time_minutes = starting_time_arr.first.to_i*60 + starting_time_arr.last.to_i

    fi.each do |fil|
      biggest_movie_length = filter(fil).map(&:time).sort.last
      period_ending = starting_time_minutes + biggest_movie_length
      time_range = Time.at(starting_time_minutes*60).utc.strftime("%H:%M")..Time.at(period_ending*60).utc.strftime("%H:%M")
      
      t_r << time_range
      starting_time_minutes = period_ending
    end

    de.each do |desc|
      i = de.index(desc)
      period t_r[i] do
      description de[i]
      filters fi[i]
      price pr[i]
      hall ha[i]
      end 
    end

    raise 'Есть дыры в расписании' if !self.no_holes?
    raise 'Расписание не корректно' if !self.valid?
  end


  def no_holes?
    @periods.combination(2).select{|a, b| b.intersect?(a) }.length == (@periods.length - 1)
  end
end
