require 'open-uri'
require 'open_uri_redirections'
require 'nokogiri'
require './movie_collection'
require 'progress_bar'
require './extra'

module Extra
  class BudgetDownloader

    def initialize(collection)
      @collection = collection
    end

    def download_for(movie)
      div = open_from_hard(movie).at('div.txt-block:contains("Budget:")') or return nil
      div.search('span').each{ |src| src.remove }
      div.text.strip.sub(/^Budget:/, '')
    end

    def load_all!
      bar = ProgressBar.new(@collection.to_a.length)
      @data = @collection.map do |movie| 
        bar.increment!
        {movie.imdb_id => {:budget => download_for(movie)}}
      end
      @data = @data.reduce(:merge)
    end

    def write_to(path)
      File.write(path, @data.to_yaml)
    end

    private 

    def open_page(link)
      open(link, :allow_redirections => :safe)
    end

    def download_page(movie)
      File.write("./tmp/#{movie.imdb_id}.html", open_page(movie.link).read)
    end

    def open_from_hard(movie)
      download_page(movie) if !File.exist?("./tmp/#{movie.imdb_id}.html")
      Nokogiri::HTML(File.read("./tmp/#{movie.imdb_id}.html"))
    end

  end
end