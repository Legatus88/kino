require './movie_collection'
require 'yaml'
require 'themoviedb-api'
require 'progress_bar'

class PosterTitle
  
  def initialize(collection)
    @collection = collection
    @big_hash = {}
  end

  def movie_poster(path)
    "http://image.tmdb.org/t/p/w185/#{path}"    
  end

  def fill_big_hash(mov)
    imdb_id = mov.link.split('/')[4]
    full_movie = Tmdb::Find.movie(imdb_id, external_source: 'imdb_id').first
    id = full_movie.id

    poster = movie_poster(full_movie.poster_path)
    
    alt_titles = Tmdb::Movie.alternative_titles(id)
    if alt_titles.any?{|var| var.iso_3166_1.eql? "RU"}
      russian_title = alt_titles.select{|var| var.iso_3166_1.eql? "RU"}.first.title
    else 
      russian_title = mov.title
    end

    id_key = imdb_id.to_sym
    @big_hash[id_key] = [{:poster => poster, :ru_title => russian_title}]   
  end

  def write_to_file(path)
    bar = ProgressBar.new(@collection.all.length)
    @collection.each do |mov| 
      fill_big_hash(mov)
      bar.increment!
    end
    File.write(path, @big_hash.to_yaml)    
  end
end
