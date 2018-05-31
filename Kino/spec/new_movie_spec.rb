require './new_movie'
require 'rspec/its'

describe NewMovie do
  subject { NewMovie.new({ link: 'http://imdb.com/title/tt0167260/?ref_=chttp_tt_9', 
      title: 'The Lord of the Rings: The Return of the King',
      year: 2003,
      country: 'USA',
      starting_date: 2003-12-17,
      genre: 'Adventure,Fantasy',
      time: '201 min',
      rate: 8.9,
      producer: 'Peter Jackson',
      actors: 'Elijah Wood,Viggo Mortensen,Ian McKellen' }, self) }
  
  its(:description) { is_expected.to eq('The Lord of the Rings: The Return of the King - новинка, вышло 15 лет назад!') }
  its(:price) { is_expected.to eq(5) }
end