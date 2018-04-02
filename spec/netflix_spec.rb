require './netflix'

describe '.pay' do
  it 'should be 25' do
  	oc = Netflix.new('movies.txt')
  	oc.pay(25) 
    expect(oc.balance).to be == 25 
  end
end

describe '.show' do
  it 'raise an error' do
  	oc = Netflix.new('movies.txt')
  	oc.pay(0.5)
  	expect(oc.show(title: /term/i)).to raise_error ArgumentError, "Need more money"
  end
end

describe '.how_much?' do
  it 'should give a price' do
  	expect(Netflix.new('movies.txt').how_much?("The Terminator")).to be == 3
  end
end