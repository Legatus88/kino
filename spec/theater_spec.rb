require './theater'

describe Theater do
  
  let(:theater) { Theater.new('movies.txt') }  
 
  describe '.show' do

    context 'when user gives a time' do
      it 'gives a random ancient movie' do
        expect(theater.show('08:00')).to match /Casablanca|Dictator|Kane|Indemnity|Rebecca|Maltese|Wrath|Laura/i
      end
    end 

    context 'when the time is wrong' do
      it 'raise NoMethodError' do
      	expect{ theater.show('01:00') }.to raise_error NoMethodError
      end
    end	
  end   

  describe '.when?' do
  	context 'when movie is in the morning timetable' do
  	  it 'gives a time range' do
  	  	expect(theater.when?('Citizen Kane')).to eq(['08:00'..'12:00'])
  	  end
    end

    context 'when movie is not in the timetable' do 
      it 'gives nothing' do
      	expect(theater.when?('The Terminator')).to eq([])
      end
    end
  end
end