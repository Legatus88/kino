require './ancient_movie'
require './netflix.rb'

describe '.description' do
  it 'gives an Array of movies' do 
    expect(MovieCollection.new('movies.txt').filter(period: :modern).first.description).to match /современное кино/i
  end
end

describe '.price' do
  it 'gives movie\'s cost' do
  	expect(MovieCollection.new('movies.txt').filter(period: :modern).first.price).to be == 3
  end
end