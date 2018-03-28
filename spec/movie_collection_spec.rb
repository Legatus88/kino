require './movie_collection'
require './movie'

describe Netflix do
  it "should give a string" do 
  	expect(Netflix.new('movies.txt').show(title: /term/i)).to include(/now sho/i)
  end
end