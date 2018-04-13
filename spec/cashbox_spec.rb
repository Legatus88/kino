require './cashbox'

describe Cashbox do

  let(:including_class) { Class.new { include Cashbox } }
  let(:cashbox) { including_class.new }

  describe '.add_money' do
  	context 'when amount is not correct' do
  	  it 'raise ArgumentError' do
  	  	expect{ cashbox.add_money(-200) }.to raise_error ArgumentError
      end
  	end

  	context 'when amount is correct' do 
  	  it 'adds cash' do
  	  	expect{ cashbox.add_money(200)}.to change { cashbox.cash.to_i }.from(0).to(2)
  	  end
  	end

  end

  describe '.take' do
    before { cashbox.add_money(200) }

    context 'when it\'s not a Bank' do
      it 'raises error' do
     	expect{ cashbox.take("Not a Bank") }.to raise_error(ArgumentError, 'CALLING POLICE') and not change(cashbox.cash)
      end
    end

    context 'when it\'s a Bank' do
      it 'make cashbox empty' do
      	expect{ cashbox.take("Bank") }.to output('Проведена инкассация').to_stdout and change { cashbox.cash }.to(0)
      end
    end
  end
end