require './movie_collection'
require 'yaml'
require 'themoviedb-api'
require 'progress_bar'
require './saver'

class PosterDownloader
  attr_accessor :collection

  def initialize(collection)
    @collection = collection
    @big_hash = {}
  end

  def imdb_id(movie)
    movie.link.split('/')[4]
  end

  # обращение к TMDB
  def full_movie(movie)
    Tmdb::Find.movie(imdb_id(movie), external_source: 'imdb_id').first
  end

  # загрузка одного постера
  def download_for(movie)
    movie_poster = "http://image.tmdb.org/t/p/w185/#{full_movie(movie).poster_path}" 
    id_key = imdb_id(movie).to_sym
    @big_hash[id_key] = [movie_poster]
  end

  # загрузка всех постеров
  def download
    bar = ProgressBar.new(@collection.all.length)
    @collection.each do |movie| 
      download_for(movie)
      bar.increment!
    end
    Saver.new(@big_hash)
  end
end
