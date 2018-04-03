require './netflix.rb'

mov = MovieCollection.new('movies.txt').filter(period: :new).first

describe '.description' do
  it 'gives NewMovie description' do 
    expect(mov.description).to match /новинка/i
  end
end

describe '.price' do
  it 'gives NewMovie\'s price' do
  	expect(MovieCollection.new('movies.txt').filter(period: :new).first.price).to be == 5
  end
end