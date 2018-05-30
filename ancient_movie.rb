require 'csv'
require './movie'

# AncientMovie class
class AncientMovie < Movie
  COST = Money.new(100, 'USD')

  def description
    "#{title} - старый фильм(#{year})"
  end
end
