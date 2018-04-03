require './modern_movie'

describe ModernMovie do
  let(:movie) { ModernMovie.create({ link: 'http://imdb.com/title/tt0110912/?ref_=chttp_tt_7', 
      title: 'Pulp Fiction',
      year: 1994,
      country: 'USA',
      starting_date: 1994-10-14,
      genre: 'Crime,Drama',
      time: '154 min',
      rate: 8.9,
      producer: 'Quentin Tarantino',
      actors: 'John Travolta,Uma Thurman,Samuel L. Jackson' }, self) }

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