require './theater'

describe Theater do
  
  let(:theater) { Theater.new('movies.txt') }  
   
  describe '.show' do
    
    context 'when gets morning time' do
      it 'gives period: :ancient filter' do
        allow(theater).to receive(:filter).and_return([AncientMovie.new({title: "Citizen Kane", rate: 8.4, year: 1940, genre: 'Drama,Mystery', period: :ancient, actors: 'Orson Welles,Joseph Cotten,Dorothy Comingore'}, 'something')])
        theater.show('08:00')
        expect(theater).to have_received(:filter).with(period: :ancient)
      end
    end 

    context 'when gets morning time' do
      it 'prints a correct string' do
        allow(theater).to receive(:filter).and_return([AncientMovie.new({title: "Citizen Kane", rate: 8.4, year: 1940, genre: 'Drama,Mystery', period: :ancient, actors: 'Orson Welles,Joseph Cotten,Dorothy Comingore'}, 'something')])
        expect{ theater.show('08:00') }.to output('Now showing: Citizen Kane 00:00:00 - 00:00:00').to_stdout
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