require 'csv'
require_relative './movie'

module Kino
  class AncientMovie < Movie
    COST = Money.new(100, 'USD')

    def description
      "#{title} - старый фильм(#{year})"
    end
  end
end
