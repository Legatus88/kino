require './theater.rb'

class Period
  def initialize time_range, &block
    @time_range = time_range
    @att_arr = []
    instance_eval &block if block_given?
  end

  def description val
    @period_description = val
    @att_arr << @period_description   
  end

  def filters val
    @period_filters = val    
    @att_arr << @period_filters
  end

  def price val
    @period_price = val
    @att_arr << @period_price
  end

  def hall *val
    @period_hall = val
    @att_arr << @period_hall
    @att_arr.select{|cell| !cell.nil?}
  end

  def title val
    @period_filters = {title: val}
    @att_arr << @period_filters
  end

  attr :period_title
  attr :time_range
  attr :period_description
  attr :period_filters
  attr :period_price
  attr :period_hall  
  attr :att_arr
  
end
