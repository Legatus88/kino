require './budget_downloader'
require 'vcr'
require './saver'

describe BudgetDownloader do 

  let(:collection) { MovieCollection.new('movies.txt') }
  let(:budget_downloader) { BudgetDownloader.new(collection) }
  let(:budget_downloader_short) { BudgetDownloader.new(collection.first(5))}
  let(:first_movie) { collection.all.first }
  let(:link) { first_movie.link }

  describe "#page_open" do
  	it "gives HTML page" do 
      VCR.use_cassette('/vcr/html_page') do
	    page = budget_downloader.page_open(link)
	    expect(page.class).to eq(Nokogiri::HTML::Document)
	    expect(page.css('h1').text.strip).to eq('Побег из Шоушенка (1994)')
	  end
	end
  end

  describe "#open_from_hard" do
  	it "gives HTML page" do 
      VCR.use_cassette('/vcr/html_page') do
	    page = budget_downloader.open_from_hard(first_movie)
	    expect(page.class).to eq(Nokogiri::HTML::Document)
	    expect(page.css('h1').text.strip).to eq('Побег из Шоушенка (1994)')
	  end
	end
  end

  describe "#download_for" do
    it "gives movie budget" do
      VCR.use_cassette('/vcr/html_page') do
	    expect(budget_downloader.download_for(first_movie).first).to eq('$25,000,000')     	
      end
    end
  end

  describe "#download" do
  	it "download all titles for collection" do
  	  VCR.use_cassette('/vcr/html_page') do
  	  	expect{ budget_downloader_short.download }.to change{ budget_downloader_short.big_hash.length }.from(0).to(5)
  	  end
  	end
  end
end


