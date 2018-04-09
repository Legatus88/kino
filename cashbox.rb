require 'money'

module Cashbox
  
  def initialize(money)
    @money = Money.new(0, "USD") 
  end

  def cash
    @money.format
  end

  def take(who)
    if who == "Bank"
      @money = 0 
      print "Проведена инкассация"
    else
      call_police
      puts
      raise ArgumentError, "CALLING POLICE"
    end  
  end

  def call_police 
    print "Police is coming"
  end
end