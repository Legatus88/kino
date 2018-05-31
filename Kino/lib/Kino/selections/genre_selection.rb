require '../cinema/netflix'

module Kino
  class GenreSelection
    def initialize(collection)
      @movies = collection
      @genres = @movies.map(&:genre).flatten.uniq.map(&:downcase)
      @genres.each do |genre|
        define_singleton_method(genre.to_sym) do
          @movies.select do |movie|
            movie.genre.map(&:downcase).include?(genre.to_s)
          end
        end
      end
    end
  end
end