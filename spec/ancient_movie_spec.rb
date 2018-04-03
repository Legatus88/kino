require './netflix.rb'

mov = MovieCollection.new('movies.txt').filter(period: :ancient).first

describe '.description' do
  it 'gives AncientMovie description' do 
    expect(mov.description).to match /старый фильм/i
  end
end

describe '.price' do
  it 'gives AncientMovie\'s price' do
  	expect(MovieCollection.new('movies.txt').filter(period: :ancient).first.price).to be == 1
  end
end