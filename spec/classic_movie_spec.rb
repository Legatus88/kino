require './ancient_movie'
require './netflix.rb'

describe '.description' do
  it 'gives an Array of movies' do 
    expect(MovieCollection.new('movies.txt').filter(period: :classic).first.description.length).to be <= 10
  end
end

describe '.price' do
  it 'gives movie\'s cost' do
  	expect(MovieCollection.new('movies.txt').filter(period: :classic).first.price).to be == 1.5
  end
end