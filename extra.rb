require 'open-uri'
require 'open_uri_redirections'
require 'nokogiri'
require './movie_collection'
require 'progress_bar'

module Extra
  def data_tmdb
    @tmdb ||= YAML.load(File.read('./title_and_poster.yml'))
  end

  def data_budget
    @budget ||= YAML.load(File.read('./budget.yml'))  	
  end

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
	  @data = @data.reduce Hash.new, :merge 
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

  class TMDBDownloader
   
    def initialize(collection)
      @collection = collection
      Tmdb::Api.key(ENV['API_KEY'])
      Tmdb::Api.language("ru")
    end

    def download_for(movie)
      info = full_movie(movie)
      title = info.title
      poster = "http://image.tmdb.org/t/p/w185/#{info.poster_path}"
      {movie.imdb_id => {title: title, poster: poster}}
    end

  	def load_all!
      bar = ProgressBar.new(@collection.to_a.length)
      @data = @collection.map do |movie| 
        bar.increment!
        download_for(movie)
      end
      @data = @data.reduce Hash.new, :merge 
    end

    def write(path)
      File.write(path, @data.to_yaml)
    end

    private

    def full_movie(movie)
      Tmdb::Find.movie(movie.imdb_id, external_source: 'imdb_id').first
    end
  end  
end