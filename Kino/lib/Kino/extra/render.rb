require 'haml'
require '../cinema/movie_collection'

module Kino
  def write_haml(path)
    template = File.read('./includes/index.haml')
    haml_engine = Haml::Engine.new(template)
    # rubocop:disable Metrics/LineLength
    output = haml_engine.render(Object.new, collection: MovieCollection.new('movies.txt'))
    # rubocop:enable Metrics/LineLength
    File.write(path, output)
  end
end
