require './poster_downloader.rb'
require 'vcr'

describe PosterDownloader do 
   
  let(:collection) { MovieCollection.new('movies.txt') }
  let(:poster_downloader) { PosterDownloader.new(collection) }
  let(:poster_downloader_short) { PosterDownloader.new(collection.first(5))}
  let(:first_movie) { collection.all.first }
  Tmdb::Api.key("30a084fe6001b01d304f10f8baf2cefd")

  describe "#imdb_id" do
	it 'returns first movie imdb_id' do
	  VCR.use_cassette('/vcr/full_movie') do 
	    expect(poster_downloader.imdb_id(first_movie)).to eq('tt0111161')
	  end
	end 	
  end

  describe "#full_movie" do  
    it "gives TMDB movie block" do 
      VCR.use_cassette('/vcr/full_movie') do
	    movie = poster_downloader.full_movie(first_movie)
	    expect(movie.class).to eq(Tmdb::Movie)
	    expect(movie.id).to eq(278)
	  end
	end
  end

  describe "#dowload_for" do
  	it 'returns a poster link' do
   	  VCR.use_cassette('/vcr/full_movie') do
  	    expect(poster_downloader.download_for(first_movie).first).to eq('http://image.tmdb.org/t/p/w185//9O7gLzmreU0nGkIB6K3BsJbzvNv.jpg')
  	  end
  	end

  	it 'changes big_hash' do
  	  VCR.use_cassette('/vcr/full_movie') do
	    expect{ poster_downloader.download_for(first_movie) }.to change{ poster_downloader.big_hash }.from({}).to({:tt0111161=>["http://image.tmdb.org/t/p/w185//9O7gLzmreU0nGkIB6K3BsJbzvNv.jpg"]})
	  end
  	end
  end

  describe "download" do
  	it 'downloads whole collection' do
  	  VCR.use_cassette('/vcr/full_movie') do
  	  	expect{ poster_downloader_short.download }.to change{ poster_downloader_short.big_hash.length }.from(0).to(5)
  	  end
    end
  end
end