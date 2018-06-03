require 'csv'
require_relative './movie'

module Kino
  class ClassicMovie < Movie
    COST = Money.new(150, 'USD')
    def description
      # rubocop:disable LineLength
      "#{title} — классический фильм, режиссёр #{producer}: (ещё #{col.filter(producer: producer).length} фильмов в топе)"
      # rubocop:enable LineLength
    end
  end
end