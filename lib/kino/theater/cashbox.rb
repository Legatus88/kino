require 'money'

module Kino
  module Cashbox
    def money
      @money ||= Money.new(0, 'USD')
    end

    def add_money(amount)
      raise ArgumentError if amount <= 0
      @money = money + Money.new(amount, 'USD')
    end

    def cash
      @money
    end

    def format_cash
      @money.format
    end

    def take(who)
      if who == 'Bank'
        @money = Money.new(0, 'USD')
        print 'Проведена инкассация'
      else
        call_police
        puts
        raise ArgumentError, 'CALLING POLICE'
      end
    end

    def call_police
      print 'Police is coming'
    end
  end
end