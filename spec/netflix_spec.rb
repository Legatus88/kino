require './netflix.rb'

describe Netflix do
  
  let(:netflix) { Netflix.new('movies.txt') }  
  
  describe '.pay' do
    context 'when positive amount' do 
      it 'increases balance' do
        expect{ netflix.pay(5) }.to change{ netflix.balance }.from(0).to(5)
      end
    end
    
    context 'when negative amount' do
      it 'raises RuntimeError' do
        expect{ netflix.pay(-5) }.to raise_error RuntimeError
      end
    end
  end

  describe '.show' do
    before { netflix.pay(1) }

    context "when not enough money" do
      it 'raises ArgumentError' do
        expect{ netflix.show(title: /term/i) }.to raise_error ArgumentError, "Need more money"
      end
    end
    
    context "when show a movie" do
      it 'decrease balance' do         
        expect{ netflix.show(title: 'Citizen Kane') }.to change{ netflix.balance }.from(1).to(0)
      end
    end
   
    context "when movie doesn\'t exist" do
      it 'raises NoMethodError' do
        expect{ netflix.show('wadad') }.to raise_error NoMethodError
      end
    end  
  end  

  describe '.how_much?' do
    
    context "when movie costs 3" do
      it 'shows a price' do
        expect(netflix.how_much?("The Terminator")).to match(3)
      end
    end
    
    context "when movie costs 1" do
      it "shows a price" do
        expect(netflix.how_much?("Citizen Kane")).to match(1)
      end
    end  

    context "when movie doesn\'t exist" do 
      it 'should raise NoMethodError' do
        expect{ netflix.how_much?('awdadw') }.to raise_error NoMethodError
      end
    end
  end
end