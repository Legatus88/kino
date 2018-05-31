require './modern_movie'
require 'rspec/its'

describe ModernMovie do
  subject { ModernMovie.new({ link: 'http://imdb.com/title/tt0110912/?ref_=chttp_tt_7', 
      title: 'Pulp Fiction',
      year: 1994,
      country: 'USA',
      starting_date: 1994-10-14,
      genre: 'Crime,Drama',
      time: '154 min',
      rate: 8.9,
      producer: 'Quentin Tarantino',
      actors: 'John Travolta,Uma Thurman,Samuel L. Jackson' }, self) }
  
  its(:description){ is_expected.to eq('Pulp Fiction - современное кино: John Travolta, Uma Thurman, Samuel L. Jackson') }
  its(:price){ is_expected.to eq(3) }

end