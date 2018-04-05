require 'csv'
require './movie'

class NewMovie < Movie
  COST = 5
 
  def description
    "#{title} - новинка, вышло #{Time.now.strftime("%Y").to_i - year.to_i} лет назад!"
  end
end  