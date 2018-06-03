#!/usr/bin/env ruby
require 'slop'
require_relative '../lib/kino.rb'


opts = Slop.parse do |o|
  o.integer '--pay', 'add money'
  o.string '--show', 'show movie'
end

money_amount = opts[:pay]
string_filter = opts[:show]

#key, value = string_filter.split(':')
#key = key.to_sym

#fil = Hash[key, value]

netflix = Kino::Netflix.new('../movies.txt')
#netflix.pay(money_amount)
#netflix.show(fil)

puts netflix.stats(:producer)
#puts netflix.balance