require './ancient_movie'
require './netflix.rb'

describe '.description' do
  it 'gives a description string' do 
    expect(MovieCollection.new('movies.txt').filter(period: :ancient).first.description).to match /старый фильм/i
  end
end

describe '.priece' do
  it 'gives movie\'s cost' do
  	expect(MovieCollection.new('movies.txt').filter(period: :ancient).first.price).to be == 1
  end
end