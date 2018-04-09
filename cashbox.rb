require 'money'

module Cashbox
  
  def add_money(amount)
  	if @money == nil
  	  @money = Money.new(0, "USD") 
  	end

  	@money += Money.new(amount, "USD")
  end

  def cash
    @money.format
  end

  def take(who)
    if who == "Bank"
      @money = Money.new(0, "USD") 
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