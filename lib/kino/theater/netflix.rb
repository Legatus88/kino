require_relative '../movie_collection.rb'
require_relative '../genre_selection.rb'
require_relative '../country_selection.rb'
require 'yard'

module Kino
  # Online cinema. It can take money on balance and show movies.
  # Also it has external cashbox as a module with it's own capabilities
  # such as taking cash out, calling police etc.
  # 
  # Usage:
  #
  #  netflix = Kino::Netflix.new('movies.txt')
  #  netflix.pay(25)
  #  netflix.show(genre: 'Comedy', year: 1991)
  #
  # For right initialization you need a file with movies each in this format:
  #  http://imdb.com/title/tt0111161/?ref_=chttp_tt_1|The Shawshank Redemption|1994|USA|1994-10-14|Crime,Drama|142 min|9.3|Frank Darabont|Tim Robbins,Morgan Freeman,Bob Gunton
  class Netflix < MovieCollection
    extend Cashbox

    # Shows current balance. 
    # @example
    #   Kino::Netflix.new('movies.txt').balance
    # @return [String] Money left
    def balance
      @coins.format.class
    end

    # Method for adding money to the balance.
    # add_money is a Cashbox method. Due to it's extended, add_money is a class method.
    # User can't watch a movie if he has not enougth money.
    # @param coins [Integer] some dollars
    # @raise [RuntimeError] if user would try to add < 0
    # @example 
    #   Kino::Netflix.new('movies.txt').pay(20)
    # @return [Money] added money amount
    def pay(cents)
      raise 'Wrong amount of money' if cents < 0
      @coins += Money.new(cents * 100, 'USD')
      Netflix.add_money(cents * 100)
    end

    # Filter definition method. It's used for functional programming task in lesson 9.
    # When user wants to make his own filter he gives such command:
    # {netflix.define_filter(:new_sci_fi) { |movie, year| movie.year &gt; year &amp;&amp; ... }}
    # In that moment filters hash is filled by this: {new_sci_fi: block}
    # User can add parametr to his own filter by using such command:
    # {netflix.show(new_sci_fi: 2010)}
    # That's why we need arg. In example above arg is 2010, key is new_sci_fi.
    # User can define a more private filter of common by giving such command:
    # {netflix.define_filter(:newest_sci_fi, from: :new_sci_fi, arg: 2014)}
    # The last line is for making one argunent block of two. And it is only uses when
    # we have from not nil.
    # @param key [Symbol] filter name
    # @param from [Symbol] another user's filter name. The first filter user defined himself.
    # @param agr [Integer, String] any argument 
    # @example 
    #   netflix.define_filter(:new_sci_fi) { |movie, year| movie.year &gt; year &amp;&amp; ... }
    # @example 
    #   netflix.show(new_sci_fi: 2010)
    # @example 
    #   netflix.define_filter(:newest_sci_fi, from: :new_sci_fi, arg: 2014)
    # @see show
    def define_filter(key, from: nil, arg: nil, &block)
      @filters ||= {}
      return @filters[key] = block if from.nil?
      raise ArgumentError, 'Такого фильтра не существует' if @filters[from].nil?
      @filters[key] = ->(movie) { @filters[from].call(movie, arg) }
    end

    # The main netflix method. It shows a random movie that matches the filter and
    # withdraw money from user's balance
    # @param filters [Hash] filters for movie
    # @example
    #   Kino::Netflix.new('movies.txt').show(genre: 'Comedy')
    # @return [NilClass] It prints a string
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

    # @private
    def apply_custom_filters(list, custom_filters)
      custom_filters.reduce(list) do |result, (key, value)|
        result.select do |movie|
          if value == true
            @filters[key].call(movie)
          else
            @filters[key].call(movie, value)
          end 
        end
      end
    end

    # Method shows movie's price.
    # @param name [String] movie's title
    # @raise [RuntimeError] if movie doesn't exist or it's not in the list.
    # @example 
    #   Kino::Netflix.new('movies.txt').how_much?('The Terminator')
    # @return [Money] movie's price
    def how_much?(name)
      raise ArgumentError, 'Movie not found' if filter(title: name).empty?
      filter(title: name).first.price
    end

    # Method for metaprogrammint task. Returns all movies of 
    # the selected genre.
    # @example 
    #   Kino::Netflix.new('movies.txt').by_genre.comedy
    # @return [Array] all movies of this genre
    def by_genre
      GenreSelection.new(@full_list)
    end

    # Method for metaprogrammint task. Returns all movies of 
    # the selected country.
    # @example 
    #   Kino::Netflix.new('movies.txt').by_country.canada
    # @return [Array] all movies of this country
    def by_country
      CountrySelection.new(@full_list)
    end
  end
end
