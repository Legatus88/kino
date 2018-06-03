require './ancient_movie'
require 'rspec/its'

describe AncientMovie do
  subject {
    AncientMovie.new({ link: 'http://imdb.com/title/tt0034583/?ref_=chttp_tt_32', 
      title: 'Casablanca',
      year: 1942,
      country: 'USA',
      starting_date: 1943-01-23,
      genre: 'Drama,Romance,War',
      time: '102 min',
      rate: 8.6,
      producer: 'Michael Curtiz',
      actors: 'Humphrey Bogart,Ingrid Bergman,Paul Henreid' }, self) }

  its(:description){ is_expected.to eq('Casablanca - старый фильм(1942)') }
  its(:price){ is_expected.to eq(1) }

end