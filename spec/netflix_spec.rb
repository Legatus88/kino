require './netflix.rb'

describe Netflix do
  
  let(:oc) { Netflix.new('movies.txt') }  
  
  describe '.pay' do
    context 'when positive amount' do 
      it 'increases balance' do
        expect{ oc.pay(5) }.to change{ oc.balance }.from(nil).to(5)
      end
    end
    
    context 'when negative amount' do
      it 'raises RuntimeError' do
        expect(oc.pay(-5)).to raise_error RuntimeError
      end
    end
  end

  describe '.show' do
    context "when not enough money" do
      it 'raises ArgumentError' do
        oc.pay(1)
        expect(oc.show(title: /term/i)).to raise_error ArgumentError, "Need more money"
      end
    end
    
    context "when show a movie" do
      it 'decrease balance' do 
        oc.pay(5)        
        expect{ oc.show(title: 'Citizen Kane') }.to change{ oc.balance }.from(5).to(4)
      end
    end
   
    context "when movie doesn\'t exist" do
      it 'raises NoMethodError' do
        oc.pay(5)
        expect(oc.show('wadad')).to raise_error NoMethodError
      end
    end  
  end  

  describe '.how_much?' do
    
    context "when movie costs 3" do
      it 'shows a price' do
        expect(oc.how_much?("The Terminator")).to match(3)
      end
    end
    
    context "when movie costs 1" do
      it "shows a price" do
        expect(oc.how_much?("Citizen Kane")).to match(1)
      end
    end  

    context "when movie doesn\'t exist" do 
      it 'should raise NoMethodError' do
        expect(oc.how_much?('awdadw')).to raise_error NoMethodError
      end
    end
  end
end