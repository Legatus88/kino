require 'money'

module Cashbox
  
  def init
  	@money ||= Money.new(0, "USD")
  end

  def add_money(amount)
    init
  	@money += Money.new(amount, "USD")
  end

  def cash
  	init
    @money
  end

  def format_cash
  	init
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