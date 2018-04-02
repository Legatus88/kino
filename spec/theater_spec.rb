require './theater'


describe '.when' do
  it 'should give morning time' do
  	oc = Theater.new('movies.txt')
    expect(oc.when?('Citizen Kane')).to be == ['08:00'..'12:00']
  end
end