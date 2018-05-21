require './title_downloader'
require 'vcr'
require './saver'

describe TitleDownloader do 

  let(:collection) { MovieCollection.new('movies.txt') }
  let(:title_downloader) { TitleDownloader.new(collection) }
  let(:title_downloader_short) { TitleDownloader.new(collection.first(5))}
  let(:first_movie) { collection.all.first }
  let(:link) { first_movie.link }
  Tmdb::Api.key("30a084fe6001b01d304f10f8baf2cefd")

  describe "#page_open" do
  	it "gives all titles array" do 
      VCR.use_cassette('/vcr/full_movie') do
	      titles = title_downloader.all_titles(first_movie)
	      expect(titles.first.class).to eq(Tmdb::Movie)
	    end
	  end
  end

  describe "#dowload_for" do
    it 'returns a poster link' do
      VCR.use_cassette('/vcr/full_movie') do
        expect(title_downloader.download_for(first_movie).first).to eq('The Shawshank Redemption')
      end
    end

    it 'changes big_hash' do
      VCR.use_cassette('/vcr/full_movie') do
        expect{ title_downloader.download_for(first_movie) }.to change{ title_downloader.big_hash }.from({}).to({:tt0111161=>["The Shawshank Redemption"]})
      end
    end
  end

  describe "download" do
    it 'downloads whole collection' do
      VCR.use_cassette('/vcr/full_movie') do
        expect{ title_downloader_short.download }.to change{ title_downloader_short.big_hash.length }.from(0).to(5)
      end
    end
  end
end