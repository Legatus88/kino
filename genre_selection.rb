require './netflix'

class GenreSelection
  def initialize(collection)
    @movies = collection
    @genres = @movies.map(&:genre).flatten.uniq.map(&:downcase)
    @genres.each do |genre|
      define_singleton_method(genre.to_sym) {@movies.select {|movie| movie.genre.map(&:downcase).include?("#{genre}")}}
    end
  end
end