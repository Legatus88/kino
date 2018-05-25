require 'haml'
require './movie_collection'

def write_haml(path)
  template = File.read('./includes/index.haml')
  haml_engine = Haml::Engine.new(template)
  output = haml_engine.render(Object.new, collection: MovieCollection.new('movies.txt'))
  File.write(path, output)
end
