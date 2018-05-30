require './movie_collection'
require './genre_selection'
require './country_selection'

# Online cinema class
class Netflix < MovieCollection
  extend Cashbox
  def balance
    @coins.format
  end

  def pay(coins)
    raise 'Wrong amount of money' if coins < 0
    @coins += Money.new(coins * 100, 'USD')
    Netflix.add_money(coins * 100)
  end

  def define_filter(key, from: nil, arg: nil, &block)
    @filters ||= {}
    return @filters[key] = block if from.nil?
    raise ArgumentError, 'Такого фильтра не существует' if @filters[from].nil?
    @filters[key] = ->(movie) { @filters[from].call(movie, arg) }
  end

  def show(filters = {}, &block)
    internal_filters, custom_filters = filters.partition { |key, _value| Movie.instance_methods.include?(key) }

    list = filter(internal_filters)
    list = apply_custom_filters(list, custom_filters)
    list = list.select(&block) if block_given?

    @coins >= list.first.price or raise ArgumentError, 'Need more money'
    @coins -= list.first.price
    random_movie = list.sort_by { |m| m.rate * rand }.last
    raise 'Movie not found' if random_movie.nil?
    print "Now showing: #{random_movie.title} #{Time.at(0).utc.strftime('%H:%M:%S')} - #{Time.at(random_movie.time * 60).utc.strftime('%H:%M:%S')}"
  end

  def apply_custom_filters(list, custom_filters)
    custom_filters.reduce(list) do |result, (key, value)|
      result.select do |movie|
        if value == true
          @filters[key].call(movie)
        else
          @filters[key].call(movie, value)
        end end
    end
  end

  def apply_custom_filters(list, custom_filters)
    custom_filters.reduce(list){|result, (key, value)|
      result.select{ |movie| 
        if value == true
          @hash[key].call(movie)
        else
          @hash[key].call(movie, value)
        end }}
  end

  def how_much?(name)
    raise ArgumentError, 'Movie not found' if filter(title: name).empty?
    filter(title: name).first.price
  end

  def by_genre
    GenreSelection.new(@full_list)
  end

  def by_country
    CountrySelection.new(@full_list)
  end
end
