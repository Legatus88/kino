require './ancient_movie'

describe AncientMovie do
  let(:movie) {
    AncientMovie.create({ link: 'http://imdb.com/title/tt0034583/?ref_=chttp_tt_32', 
      title: 'Casablanca',
      year: 1942,
      country: 'USA',
      starting_date: 1943-01-23,
      genre: 'Drama,Romance,War',
      time: '102 min',
      rate: 8.6,
      producer: 'Michael Curtiz',
      actors: 'Humphrey Bogart,Ingrid Bergman,Paul Henreid' }, self) }

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