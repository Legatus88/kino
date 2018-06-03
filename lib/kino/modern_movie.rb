require 'csv'
require_relative './movie'

module Kino
  class ModernMovie < Movie
    COST = Money.new(300, 'USD')

    def description
      "#{title} - современное кино: #{actors.join(', ')}"
    end
  end
end
