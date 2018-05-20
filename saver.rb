require 'yaml'

class Saver 
  def initialize(big_hash)
  	@big_hash = big_hash
  end

  def save(path)
    File.write(path, @big_hash.to_yaml)     
  end
end