require './theater.rb'

class Hall
  attr_reader :color, :title, :places

  def initialize(color, params)
    @color = color
    @title = params[:title]
    @places = params[:places]
  end
end