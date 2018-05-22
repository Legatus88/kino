require './tmdb_downloader'
require 'vcr'
require './saver'
require 'rspec/its'

describe TMDBDownloader do 

  let(:collection) { MovieCollection.new('movies.txt') }
  let(:downloader) { TMDBDownloader.new(collection) }
  let(:downloader_short) { TMDBDownloader.new(collection.first(5))}
  let(:first_movie) { collection.all.first }

  describe "#full_movie", :vcr do  
    subject { downloader.full_movie(first_movie) }
    its(:id) { is_expected.to eq(278)}
    its(:class) { is_expected.to eq(Tmdb::Movie)}
    its(:title) { is_expected.to eq('Побег из Шоушенка')}
    its(:poster_path) {is_expected.to eq('/sRBNv6399ZpCE4RrM8tRsDLSsaG.jpg')}
  end

  describe "amount fo calls", :vcr do
    it "should be true" do
      expect(Tmdb::Find).to receive(:movie).once.and_call_original
      downloader.full_movie(first_movie)
      downloader.download_title_for_movie
      downloader.download_poster_for_movie
    end
  end   

  describe "#download", :vcr do
    context "it writes posters and titles info to @data" do
      before { downloader_short.download }
      subject { downloader_short.data.length }
      it { is_expected.to eq(5) }
    end
  end
end