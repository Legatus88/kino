require './netflix.rb'

oc = Netflix.new('movies.txt')

describe '.pay' do
  
  it 'should be 25' do
  	oc.pay(5) 
    expect(oc.balance).to be == 5 
  end

  it 'should raise NameError' do
    expect(oc.pay(qw)).to raise_error NameError
  end
end

describe '.show' do

  it 'should raise an ArgumentError' do
  	oc.pay(1)
  	expect(oc.show(title: /term/i)).to raise_error ArgumentError, "Need more money"
  end

  it 'should take money' do 
    oc.pay(5)
    oc.show(title: 'Citizen Kane')
    expect(oc.balance).to be == 4
  end

  it 'should raise NoMethodError' do
    oc.pay(5)
    expect(oc.show('wadad')).to raise_error NoMethodError
  end

end

describe '.how_much?' do
  
  it 'should give a different price' do
  	expect(oc.how_much?("The Terminator")).to be == 3
    expect(oc.how_much?("Citizen Kane")).to be == 1
  end

  it 'should raise NoMethodError' do
    expect(oc.how_much?('awdadw')).to raise_error NoMethodError
  end
end