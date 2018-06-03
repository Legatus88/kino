require 'csv'
require_relative './movie'

module Kino
  class NewMovie < Movie
    COST = Money.new(500, 'USD')

    def description
      "#{title} - новинка, вышло #{Time.now.strftime('%Y').to_i - year.to_i} лет назад!"
    end
  end
end
