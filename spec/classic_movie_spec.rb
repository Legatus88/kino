require './netflix.rb'


describe ClassicMovie do
  let(:movie) { MovieCollection.new('movies.txt').filter(period: :classic).first }

  describe '.description' do
    context 'when .description is called' do
      it 'gives ClassicMovie description' do 
        expect(movie.description).to match /классический фильм, режиссёр/i
      end
    end
  end

  describe '.price' do
    context 'when price is called' do 
      it 'gives ClassicMovie\'s price' do
  	    expect(movie.price).to eq(1.5)
      end
  	end	
  end
end