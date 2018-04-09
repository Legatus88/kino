require 'money'

module Cashbox
  
  def initialize(money)
    @money = Money.new(0, "USD") 
  end

  def cash
    @money.format
  end

end