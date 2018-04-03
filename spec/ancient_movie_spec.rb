require './netflix.rb'


describe AncientMovie do
  let(:movie) { MovieCollection.new('movies.txt').filter(period: :ancient).first }

  describe '.description' do
    context 'when .description is called' do
      it 'gives AncientMovie description' do 
        expect(movie.description).to match /старый фильм/i
      end
    end
  end

  describe '.price' do
    context 'when price is called' do 
      it 'gives AncientMovie\'s price' do
  	    expect(movie.price).to eq(1)
      end
  	end	
  end
end