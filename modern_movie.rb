require 'csv'
require './movie'

# ModernMovie class
class ModernMovie < Movie
  COST = Money.new(300, 'USD')

  def description
    "#{title} - современное кино: #{actors.join(', ')}"
  end
end
