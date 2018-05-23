require './tmdb_downloader'
require 'vcr'
require 'rspec/its'

describe TMDBDownloader do 

  let(:collection) { MovieCollection.new('movies.txt') }
  let(:downloader) { TMDBDownloader.new(collection) }
  let(:downloader_short) { TMDBDownloader.new(collection.first(5))}
  let(:first_movie) { collection.all.first }

  describe "#full_movie", :vcr do  
    subject { downloader.send(:full_movie, first_movie) }
    its(:id) { is_expected.to eq(278)}
    its(:class) { is_expected.to eq(Tmdb::Movie)}
    its(:title) { is_expected.to eq('Побег из Шоушенка')}
    its(:poster_path) {is_expected.to eq('/sRBNv6399ZpCE4RrM8tRsDLSsaG.jpg')}
  end

  describe "#download_for" do
    subject { downloader.download_for(first_movie) }
    it { is_expected.to eq({:tt0111161=>[{:title=>"Побег из Шоушенка"}, {:poster=>"http://image.tmdb.org/t/p/w185//sRBNv6399ZpCE4RrM8tRsDLSsaG.jpg"}]})}
  end

  describe "amount fo calls", :vcr do
    it "should be true" do
      expect(Tmdb::Find).to receive(:movie).once.and_call_original
      downloader.download_for(first_movie)
    end
  end   

  describe "#load_all!", :vcr do
    context "it loads budget info to @data" do
      subject { downloader_short.load_all!.length }
      it { is_expected.to eq(5) }
    end
  end
end