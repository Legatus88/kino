require './budget_downloader'
require 'vcr'
require './saver'

describe BudgetDownloader do 

  let(:collection) { MovieCollection.new('movies.txt') }
  let(:budget_downloader) { BudgetDownloader.new(collection) }
  let(:budget_downloader_short) { BudgetDownloader.new(collection.first(5))}
  let(:first_movie) { collection.all.first }
  let(:last_movie) { collection.all.last }
  let(:link) { first_movie.link }

  describe "#open_page", :vcr do
  	it "gives HTML page" do 
	    page = budget_downloader.open_page(link)
      expect(page.class).to eq(Nokogiri::HTML::Document)
	    expect(page.css('h1').text.strip).to eq('Побег из Шоушенка (1994)')
	  end
  end

  describe "#open_from_hard", :vcr do
  	it "gives HTML page" do 
	    page = budget_downloader.open_from_hard(first_movie)
	    expect(page.class).to eq(Nokogiri::HTML::Document)
	    expect(page.css('h1').text.strip).to eq('Побег из Шоушенка (1994)')
  	end
  end

  describe "#wanted_div", :vcr do
    subject { budget_downloader.wanted_div(first_movie).class } 
    it { is_expected.to eq(Nokogiri::XML::Element) }     
  end

  describe "#download_for", :vcr do
    it "gives movie budget" do
      budget_downloader.wanted_div(first_movie)
	    expect(budget_downloader.download_for(first_movie)).to eq('$25,000,000')     	
    end

    it "gives movie budget" do
      budget_downloader.wanted_div(last_movie) 
      expect(budget_downloader.download_for(first_movie)).to eq('Unknown')      
    end
  end

  describe "#download", :vcr do
    context "it writes budget info to @data" do
      before { budget_downloader_short.download }
      subject { budget_downloader_short.data.length }
      it { is_expected.to eq(5) }
    end
  end
end


