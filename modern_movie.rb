require 'csv'
require './movie'

class ModernMovie < Movie
  COST = 3
  
  def description
    "#{title} - современное кино: #{actors.join(', ')}"     
  end
end
