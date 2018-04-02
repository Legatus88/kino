require './ancient_movie'
require './netflix.rb'

describe '.description' do
  it 'gives an Array of movies' do 
    expect(MovieCollection.new('movies.txt').filter(period: :new).first.description).to match /новинка/i
  end
end

describe '.price' do
  it 'gives movie\'s cost' do
  	expect(MovieCollection.new('movies.txt').filter(period: :new).first.price).to be == 5
  end
end