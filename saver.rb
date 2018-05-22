require 'yaml'

class Saver 
  def initialize(data)
  	@data = data
  end

  def save(path)
    File.write(path, @data.to_yaml)     
  end
end