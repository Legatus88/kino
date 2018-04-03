require './netflix.rb'


describe ModernMovie do
  let(:movie) { MovieCollection.new('movies.txt').filter(period: :modern).first }

  describe '.description' do
    context 'when .description is called' do
      it 'gives ModernMovie description' do 
        expect(movie.description).to match /современное кино/i
      end
    end
  end

  describe '.price' do
    context 'when price is called' do 
      it 'gives ModernMovie\'s price' do
  	    expect(movie.price).to eq(3)
      end
  	end	
  end
end