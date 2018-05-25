require './movie_collection'
require 'yaml'
require 'themoviedb-api'
require 'progress_bar'
require 'dotenv/load'

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
    @data = @data.reduce(:merge)
  end

  def write(path)
    File.write(path, @data.to_yaml)
  end

  private

  def full_movie(movie)
    Tmdb::Find.movie(movie.imdb_id, external_source: 'imdb_id').first
  end
end
