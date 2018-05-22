require './title_and_poster_downloader'
require 'vcr'
require './saver'
require 'rspec/its'

describe TitleAndPosterDownloader do 

  let(:collection) { MovieCollection.new('movies.txt') }
  let(:downloader) { TitleAndPosterDownloader.new(collection) }
  let(:downloader_short) { TitleAndPosterDownloader.new(collection.first(5))}
  let(:first_movie) { collection.all.first }
  let(:link) { first_movie.link }


  describe "#full_movie", :vcr do  
    subject { downloader.full_movie(first_movie) }
    its(:id) { is_expected.to eq(278)}
    its(:class) { is_expected.to eq(Tmdb::Movie)}
    its(:title) { is_expected.to eq('Побег из Шоушенка')}
    its(:poster_path) {is_expected.to eq('/sRBNv6399ZpCE4RrM8tRsDLSsaG.jpg')}
  end

  describe "amount fo calls", :vcr do
    it "should be true" do
      expect(full).to receive(Tmdb::Find.movie(first_movie.imdb_id, external_source: 'imdb_id').first).once
      downloader.full_movie(first_movie)
      downloader.download_title_for_movie
      downloader.download_poster_for_movie
    end
  end

  describe "#id", :vcr do
    before { downloader.full_movie(first_movie) }
    it 'returns movie\'s id' do
      expect(downloader.id).to eq(278)
    end
  end   

  describe "#download_title_for_movie", :vcr do
    before { downloader.full_movie(first_movie) }
    it 'returns movie\'s title' do
      expect(downloader.download_title_for_movie).to eq('Побег из Шоушенка')
    end
  end   

  describe "#download_poster_for_movie", :vcr do
    before { downloader.full_movie(first_movie) }
    it 'returns movie\'s poster link' do
      expect(downloader.download_poster_for_movie).to eq('http://image.tmdb.org/t/p/w185//sRBNv6399ZpCE4RrM8tRsDLSsaG.jpg')
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