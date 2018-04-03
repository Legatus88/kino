require './netflix.rb'

mov = MovieCollection.new('movies.txt').filter(period: :classic).first

describe '.description' do
  it 'gives ClassicMovie description' do 
    expect(mov.description).to match /классический фильм, режиссёр/i
  end
end

describe '.price' do
  it 'gives ClassicMovie\'s price' do
  	expect(MovieCollection.new('movies.txt').filter(period: :classic).first.price).to be == 1.5
  end
end