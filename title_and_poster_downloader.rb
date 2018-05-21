require './movie_collection'
require 'yaml'
require 'themoviedb-api'
require 'progress_bar'

class TitleDownloader
  attr_accessor :collection, :base
  
  def initialize(collection)
    @collection = collection
    @base = {}
  end

  def imdb_id(movie)
    movie.link.split('/')[4]
  end

  def id(movie)
    Tmdb::Find.movie(imdb_id, external_source: 'imdb_id').first.id
  end

  def full_movie(movie)
    Tmdb::Movie.detail(id(movie))
  end

  def download_title_for(movie)
    full_movie(movie).title
  end

  def download_poster_for(movie)
    "http://image.tmdb.org/t/p/w185/#{full_movie(movie).poster_path}" 
  end

  def saving_to_hash(movie)
    id_key = imdb_id(movie).to_sym
    @base[id_key] = [{:title => download_title_for(movie)}, {:poster => download_poster_for(movie)}]
  end

  def download
    bar = ProgressBar.new(@collection.to_a.length)
    @collection.each do |movie| 
      saving_to_hash(movie)
      bar.increment!
    end
    Saver.new(@base)  
  end
end
