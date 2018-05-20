require './movie_collection'
require 'yaml'
require 'themoviedb-api'
require 'progress_bar'

class TitleDownloader
  
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

  def all_titles(movie)
    id = full_movie(movie).id
    Tmdb::Movie.alternative_titles(id)
  end

  def download_for(movie)
    if all_titles(movie).any?{|var| var.iso_3166_1.eql? "RU"}
      russian_title = all_titles(movie).select{|var| var.iso_3166_1.eql? "RU"}.first.title
    else 
      russian_title = movie.title
    end

    id_key = imdb_id(movie).to_sym
    @big_hash[id_key] = [russian_title]   
  end

  def download
    bar = ProgressBar.new(@collection.all.length)
    @collection.each do |movie| 
      download_for(movie)
      bar.increment!
    end
    Saver.new(@big_hash)  
  end
end
