require './movie_collection'
require './movie'

#describe Netflix do
#  it "should give an arr" do 
#  	expect(Netflix.new('movies.txt').show(title: /term/i)).to eql([])
#  end
#end

#describe Netflix do
#  it "should be 8" do
#    expect(Netflix.new('movies.txt').csv_list.select{|movie| (1940..1945) === movie[:year].to_i}.length).to eq(8)
# end
#end

#describe Netflix do
#  Netflix.new('movies.txt').pay(25)
#  it "should be 25" do
#    expect(Netflix.new('movies.txt').balance).to eq(25)
#  end
#end

describe Theater do
	it "should be Range" do
		expect(Theater.new('movies.txt').when?('Fargo')).to eq(["18:00".."23:00"]) 
	end
end
