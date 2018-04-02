require './theater'


describe '.when' do
  it 'give an AncientMovie list' do
  	oc = Theater.new('movies.txt')
    expect(oc.when?('Citizen Kane')).to be == ['08:00'..'12:00']
  end
end