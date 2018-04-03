require './netflix.rb'


describe NewMovie do
  let(:movie) { MovieCollection.new('movies.txt').filter(period: :new).first }

  describe '.description' do
    context 'when .description is called' do
      it 'gives NewMovie description' do 
        expect(movie.description).to match /новинка/i
      end
    end
  end

  describe '.price' do
    context 'when price is called' do 
      it 'gives NewMovie\'s price' do
  	    expect(movie.price).to eq(5)
      end
  	end	
  end
end