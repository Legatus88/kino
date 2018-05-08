require './netflix'

class CountrySelection
  def initialize(collection)
    @movies = collection
  end

  def selection(mov_country)
    @movies.select{|movie| movie.country.downcase == mov_country.to_s}
  end
  
  def method_missing(meth)
    if @movies.any?{|movie| movie.country.downcase == meth.to_s}
      selection(meth)
    else
    # зачем вызывать super? сказано, что код будет вести себя "странно", если его не добавлять
      super
    end
  end

# зачем нужен этот метод? объяснений не найдено, сказано только, что 
# используется крайне редко, но использовать полезно
  def respond_to?(meth)
    if @movies.any?{|movie| movie.country.downcase == meth.to_s}
      true
    else
      super
    end
  end
end