require './movie_collection'
require 'yaml'
require 'themoviedb-api'
require 'progress_bar'
require './saver'
require 'dotenv/load'

class TMDBDownloader
   
  def initialize(collection)
    @collection = collection
    Tmdb::Api.key(ENV['API_KEY'])
    Tmdb::Api.language("ru")
  end

  def id
    @full_movie.id
  end

  def full_movie(movie)
    @full_movie = Tmdb::Find.movie(movie.imdb_id, external_source: 'imdb_id').first
  end

  def download_title_for_movie
    @full_movie.title
  end

  def download_poster_for_movie
    "http://image.tmdb.org/t/p/w185/#{@full_movie.poster_path}" 
  end

  def download
    bar = ProgressBar.new(@collection.to_a.length)
    @data = @collection.map do |movie| 
      full_movie(movie)
      bar.increment!
      {movie.imdb_id.to_sym => [{:title => download_title_for_movie}, {:poster => download_poster_for_movie}]}
    end
    Saver.new(@data)  
  end

  def data # нужен только для тестирования download
    @data
  end
end
