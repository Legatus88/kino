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
    if !from.nil? 
      @hash[name] = ->(movie) { @hash[from].call(movie, arg) }
    else
      @hash = {name => block} 
    end
  end 

  def show(parametr={}, &block)

    combined_parametrs = parametr.partition{ |key, value| all.first.my_hash[key] }
    new_param = combined_parametrs[0].to_h
    new_block = combined_parametrs[1].to_h

    if new_block.length > 0
      list = new_block.reduce(filter(new_param)){|result, (key, value)| 
        result.select{|movie| 
          if value == true
            @hash[key].call(movie)
          else 
            @hash[key].call(movie, value)
          end}}.select(&block)
    else
      list = filter(new_param).select(&block)
    end

    @coins >= list.first.price or raise ArgumentError, "Need more money"
    @coins -= list.first.price
    random_movie = list.sort_by { |m| m.rate * rand }.last
    print "Now showing: #{random_movie.title} #{Time.at(0).utc.strftime("%H:%M:%S")} - #{Time.at(random_movie.time*60).utc.strftime("%H:%M:%S")}"       
  end

  def how_much?(name)
    filter(title: name).first.price
  end
end
