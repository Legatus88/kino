require './movie'
require './ancient_movie'


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
      actors: 'Humphrey Bogart,Ingrid Bergman,Paul Henreid' }, self)}
  
#======================================================================= 
  describe '.title' do
    context 'when value default' do
      it 'returns a string' do
      	expect(movie.title.class).to equal(String)
      end
    end
  end
 
  describe '.year' do
    context 'when value converted to integer' do
      it 'returns an Integer' do
      	expect(movie.year.class).to equal(Fixnum)
      end
    end
  end
  
  describe '.genre' do
    context 'when value splitted' do
      it 'returns an Array' do
      	expect(movie.genre.class).to equal(Array)
      end
    end
  end

  describe '.rate' do
    context 'when value floated' do
      it 'returns a Float' do
      	expect(movie.rate.class).to equal(Float)
      end
    end
  end	

  describe '.period' do
    context 'when value is symboled' do
      it 'returns a Symbol' do
      	expect(movie.period.class).to equal(Symbol)
      end
    end
  end
#======================================================================= 


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

 
end