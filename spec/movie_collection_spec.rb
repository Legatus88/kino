require './movie_collection'

describe MovieCollection do 

  let (:collection) { MovieCollection.new('movies.txt') }

  describe '.sort_by' do
  	context 'when arguments are correct' do 
  	  it 'returns an Array' do 		
  	  	expect(collection.sort_by(:title).class).to equal(Array)
  	  end
  	end

  	context 'when arguments are not' do
  	  it 'raise NoMethodError' do
  	  	expect{ collection.sort_by(:tralala) }.to raise_error NoMethodError
  	  end
  	end
  end

  describe '.filter' do 
  	
  	context 'when arguments are correct' do
  	  it 'returns an Array ' do
  	  	expect(collection.filter(title: /term/i).class).to equal(Array)
  	  end
  	end
  	
  	context 'when key is not correct' do
  	  it 'raises NoMethodError' do
  	  	expect{ collection.filter(tralala: /term/i) }.to raise_error NoMethodError
  	  end
  	end 	
  	
  	context 'when value is not correct' do
  	  it 'raises NameError' do
  	  	expect{ collection.filter(title: awdawd) }.to raise_error NameError
  	  end
  	end

  	context 'when value doesn\'t exist' do
  	  it 'returns nothing' do
  	  	expect(collection.filter(title: /Бригада/i)).to eq([])
  	  end
 	end
  end

  describe '.stats' do
  	context 'when key is correct' do
      it 'returns hash' do
  	    expect(collection.stats(:producer).class).to equal(Hash)
  	  end
  	end

  	context 'when key is not correct' do
  	  it 'raises NameError' do
  	  	expect{ collection.stats(tralala)}.to raise_error NameError
  	  end
  	end

  	context 'when key doesn\'t exist' do
  	  it 'raises NoMethodError' do
  	  	expect{ collection.stats(:tralala)}.to raise_error NoMethodError
  	  end
  	end	
  end
end
