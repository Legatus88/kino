require './movie'
require './ancient_movie'
require './classic_movie'
require './modern_movie'
require './new_movie'


describe Movie do

  let (:movie) {
  	  Movie.create({ link: 'http://imdb.com/title/tt0034583/?ref_=chttp_tt_32', 
      title: 'Casablanca',
      year: 1942,
      country: 'USA',
      starting_date: 1943-01-23,
      genre: 'Drama,Romance,War',
      time: '102 min',
      rate: 8.6,
      producer: 'Michael Curtiz',
      actors: 'Humphrey Bogart,Ingrid Bergman,Paul Henreid' }, col)}
  
  let (:movie_classic) {
  	  Movie.create({ link: 'http://imdb.com/title/tt0034583/?ref_=chttp_tt_32', 
      title: 'Casablanca',
      year: 1965,
      country: 'USA',
      starting_date: 1943-01-23,
      genre: 'Drama,Romance,War',
      time: '102 min',
      rate: 8.6,
      producer: 'Michael Curtiz',
      actors: 'Humphrey Bogart,Ingrid Bergman,Paul Henreid' }, col)}

  let (:movie_modern) {
  	  Movie.create({ link: 'http://imdb.com/title/tt0034583/?ref_=chttp_tt_32', 
      title: 'Casablanca',
      year: 1975,
      country: 'USA',
      starting_date: 1943-01-23,
      genre: 'Drama,Romance,War',
      time: '102 min',
      rate: 8.6,
      producer: 'Michael Curtiz',
      actors: 'Humphrey Bogart,Ingrid Bergman,Paul Henreid' }, col)}
  
  let (:movie_new) {
  	  Movie.create({ link: 'http://imdb.com/title/tt0034583/?ref_=chttp_tt_32', 
      title: 'Casablanca',
      year: 2010,
      country: 'USA',
      starting_date: 1943-01-23,
      genre: 'Drama,Romance,War',
      time: '102 min',
      rate: 8.6,
      producer: 'Michael Curtiz',
      actors: 'Humphrey Bogart,Ingrid Bergman,Paul Henreid' }, col)}

  let(:col) { double(genre_list: ['Comedy', 'Drama', 'Crime']) }

  describe '.has_genre?' do
    context 'when movie has this genre' do
      it 'returns true' do
      	expect(movie.has_genre?('Drama')).to equal(true)
      end
    end

    context 'when movie hasn\'t this, but is exists' do
      it 'returns false' do
      	expect(movie.has_genre?('Comedy')).to equal(false)
      end
    end

    context 'when this genre doesn\'t exist' do
 	  it 'raises error' do
 	  	expect{ movie.has_genre?('tralala') }.to raise_error ArgumentError, 'Sorry, this GENRE doesn\'t exist'
 	  end
    end
  end

  describe '.matches?' do
  	context 'when it does match' do 
  	  it 'returns true' do
  	  	expect(movie.matches?(:genre, 'Drama')).to equal(true)
  	  end
  	end
  	  
  	context 'when it doesn\'t match' do
  	  it 'returns false' do
  	  	expect(movie.matches?(:genre, 'Comedy')).to equal(false)
  	  end
  	end

  	context 'when only one argument' do
  	  it 'returns ArgumentError' do
  	  	expect{ movie.matches?(:genre) }.to raise_error ArgumentError
  	  end
  	end
  	
  	context 'when first argument is wrong' do
  	  it 'returns NoMethodError' do
  	  	expect{ movie.matches?(:tralala, 'Comedy')}.to raise_error NoMethodError
  	  end
  	end
  end

  describe '.self.create' do
  	context 'when movie is ancient' do
      it 'creates an AncientMovie' do
      	expect(movie.class).to eq(AncientMovie)
      end
  	end

  	context 'when movie is classic' do
      it 'creates an ClassicMovie' do
      	expect(movie_classic.class).to eq(ClassicMovie)
      end
  	end

  	context 'when movie is modern' do
      it 'creates an ModernMovie' do
      	expect(movie_modern.class).to eq(ModernMovie)
      end
  	end

  	context 'when movie is new' do
      it 'creates an NewMovie' do
      	expect(movie_new.class).to eq(NewMovie)
      end
  	end
  end
end