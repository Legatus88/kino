require './poster_downloader.rb'
require './saver.rb'

describe PosterDownloader do 
   
  let(:collection) { MovieCollection.new('movies.txt') }
  let(:poster_downloader) { PosterDownloader.new(collection) }

  describe "#full_movie" do 
	  
    it "gives TMDB movie block" do 
      VCR.use_cassette('/vcr/full_movie') do
	    movie = poster_downloader.full_movie(collection.all.first)
	    expect(movie.class).to eq(Tmdb::Movie)
	    expect(movie.id).to eq(278)
	  end
	end
  end

  describe "#imdb_id" do
	
	it 'returns first movie imdb_id' do
	  VCR.use_cassette('TMDB/full_movie') do 
	    expect{ poster_downloader.imdb_id(collection.all.first) }.to eq('tt0111161')
	  end
	end 	
  end
end
