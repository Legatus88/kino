require './new_movie'

describe NewMovie do
  let(:movie) { NewMovie.create({ link: 'http://imdb.com/title/tt0167260/?ref_=chttp_tt_9', 
      title: 'The Lord of the Rings: The Return of the King',
      year: 2003,
      country: 'USA',
      starting_date: 2003-12-17,
      genre: 'Adventure,Fantasy',
      time: '201 min',
      rate: 8.9,
      producer: 'Peter Jackson',
      actors: 'Elijah Wood,Viggo Mortensen,Ian McKellen' }, self) }

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