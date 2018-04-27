require './theater.rb'

class Hall
  # accessor или reader? или без разницы?
  attr_reader :color, :title, :places

  def initialize(color, title=nil, places=nil)
    @color = color
    @title = title
    @places = places
  end
end