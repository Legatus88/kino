require './budget_downloader'
require 'vcr'

describe BudgetDownloader do 

  let(:collection) { MovieCollection.new('movies.txt') }
  let(:budget_downloader) { BudgetDownloader.new(collection) }
  let(:budget_downloader_short) { BudgetDownloader.new(collection.first(5))}
  let(:first_movie) { collection.all.first }
  let(:last_movie) { collection.all.last }
  let(:link) { first_movie.link }

  describe "#open_from_hard", :vcr do
  	it "gives HTML page" do 
	    page = budget_downloader.send(:open_from_hard, first_movie)
	    expect(page.class).to eq(Nokogiri::HTML::Document)
	    expect(page.css('h1').text.strip).to eq('Побег из Шоушенка (1994)')
  	end
  end

  describe "#download_for", :vcr do
    context 'gives a real budget' do
      subject { budget_downloader.download_for(first_movie) }
      it { is_expected.to eq('$25,000,000') }
    end

    context 'gives an unknown budget' do
      subject { budget_downloader.download_for(last_movie) }
      it { is_expected.to eq(nil) }
    end
  end

  describe "#load_all!", :vcr do
    context "it loads budget info to @data" do
      subject { budget_downloader_short.load_all!.length }
      it { is_expected.to eq(5) }
    end
  end
end


