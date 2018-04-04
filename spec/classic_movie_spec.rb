require './classic_movie'

describe ClassicMovie do
  let(:movie) {
     ClassicMovie.create({ link: 'http://imdb.com/title/tt0050083/?ref_=chttp_tt_5', 
      title: '12 Angry Men',
      year: 1957,
      country: 'USA',
      starting_date: 1957-04,
      genre: 'Crime,Drama',
      time: '96 min',
      rate: 8.9,
      producer: 'Sidney Lumet',
      actors: 'Henry Fonda,Lee J. Cobb,Martin Balsam' }, collection) }

  let(:collection) { double(filter: double(length: 8)) }

  describe '.description' do
    context 'when .description is called' do
      it 'gives ClassicMovie description' do
        expect(movie.description.to_s).to match /классический фильм, режиссёр/i
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