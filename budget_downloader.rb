require 'open-uri'
require 'open_uri_redirections'
require 'nokogiri'
require './movie_collection'
require 'progress_bar'


class BudgetDownloader

  def initialize(collection)
    @collection = collection
  end

  def open_page(link)
    html = open(link, :allow_redirections => :safe) # только так удалось выполнить редирект
    Nokogiri::HTML(html)
  end

  def download_page(link)
    File.write('./page.html', open_page(link))
  end

  def open_from_hard(movie)
    download_page(movie.link)
    Nokogiri::HTML(File.read('page.html'))
  end

  def wanted_div(movie)
    @div = open_from_hard(movie).at('div.txt-block:contains("Budget:")')
  end

  def download_for(movie)
    if !@div.nil?
      @div.search('span').each{ |src| src.remove }
      @div.text.strip.sub(/^Budget:/, '')
    else
      'Unknown'
    end
  end

  def download
    bar = ProgressBar.new(@collection.to_a.length)
    @data = @collection.map do |movie| 
      wanted_div(movie)
      bar.increment!
      {movie.imdb_id.to_sym => [{:budget => download_for(movie)}]}
    end
    Saver.new(@data)  
  end

  def data # нужен только для тестирования download
    @data
  end
end
