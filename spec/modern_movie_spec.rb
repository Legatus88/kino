require './netflix.rb'

mov = MovieCollection.new('movies.txt').filter(period: :modern).first

describe '.description' do
  it 'gives ModernMovie description' do 
    expect(mov.description).to match /современное кино/i
  end
end

describe '.price' do
  it 'gives ModernMovie\'s price' do
  	expect(MovieCollection.new('movies.txt').filter(period: :modern).first.price).to be == 3
  end
end