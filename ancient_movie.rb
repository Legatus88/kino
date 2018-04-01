require 'csv'
require './movie'

class AncientMovie < Movie
  COST = 1
  
  def description 
    "#{title} - старый фильм(#{year})"
  end
end