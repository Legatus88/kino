require './classic_movie'
require 'rspec/its'

describe ClassicMovie do
  subject {
     ClassicMovie.new({ link: 'http://imdb.com/title/tt0050083/?ref_=chttp_tt_5', 
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

  its(:description) { is_expected.to eq('12 Angry Men — классический фильм, режиссёр Sidney Lumet: (ещё 8 фильмов в топе)') }
  its(:price) { is_expected.to eq(1.5) }
end