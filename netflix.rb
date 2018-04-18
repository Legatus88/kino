require './movie_collection'

class Netflix < MovieCollection
  extend Cashbox
  
  def balance
    @coins.format
  end

  def pay(coins)
    if coins < 0 
      raise RuntimeError, "Wrong amount of money"
    end
    @coins += Money.new(coins*100, "USD")
    Netflix.add_money(coins*100) 
  end

  def define_filter(name, from: nil, arg: nil, &block)
    @hash ||= {}    
    return @hash[name] = block if from.nil?
    raise ArgumentError, "Такого фильтра не существует" if @hash[from].nil?
    @hash[name] = ->(movie) { @hash[from].call(movie, arg) }
  end
  
  def show(filters={}, &block)

    internal_filters, custom_filters = filters.partition{ |key, value| Movie.methods.include?(key) }

    list = filter(internal_filters)
    list = apply_custom_filters(list, custom_filters)
    list.select(&block)

    @coins >= list.first.price or raise ArgumentError, "Need more money"
    @coins -= list.first.price
    random_movie = list.sort_by { |m| m.rate * rand }.last
    print "Now showing: #{random_movie.title} #{Time.at(0).utc.strftime("%H:%M:%S")} - #{Time.at(random_movie.time*60).utc.strftime("%H:%M:%S")}"       
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
    filter(title: name).first.price
  end
end
