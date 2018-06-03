require './theater'

describe Theater do
  
  let(:th) { Theater.new('movies.txt') }
  let(:theater) { Theater.new('movies.txt') do
    hall :red, title: 'Красный зал', places: 100
    hall :blue, title: 'Синий зал', places: 50
    hall :green, title: 'Зелёный зал (deluxe)', places: 12

    period '09:00'..'11:00' do
      description 'Утренний сеанс'
      filters genre: 'Comedy', year: 1900..1980
      price 10
      hall :red, :blue
    end

    period '11:00'..'16:00' do
      description 'Спецпоказ'
      title 'The Terminator'
      price 50
      hall :green
    end

    period '16:00'..'20:00' do
      description 'Вечерний сеанс'
      filters genre: ['Action', 'Drama'], year: 2007..Time.now.year, title: 'Mad Max: Fury Road'
      price 20
      hall :red, :blue
    end

    period '19:00'..'22:00' do
      description 'Вечерний сеанс для киноманов'
      filters year: 1900..1945, exclude_country: 'USA', title: 'M'
      price 30
      hall :green
    end
  end }  
   
  
  describe 'creation' do

    context 'when holes in timetable are exist' do 
      subject do 
        Theater.new('movies.txt') do
          hall :red, title: 'Красный зал', places: 100
          hall :blue, title: 'Синий зал', places: 50
          hall :green, title: 'Зелёный зал (deluxe)', places: 12

          period '09:00'..'11:00' do
          description 'Утренний сеанс'
          filters genre: 'Comedy', year: 1900..1980
          price 10
          hall :red, :blue
          end

          period '12:00'..'16:00' do
          description 'Спецпоказ'
          title 'The Terminator'
          price 50
          hall :red
          end
        end
      end

      it 'raises RuntimeError' do
        expect{ subject }.to raise_error RuntimeError
      end
    end

    context 'when timetable is incorrect' do
      subject do 
        Theater.new('movies.txt') do
          hall :red, title: 'Красный зал', places: 100
          hall :blue, title: 'Синий зал', places: 50
          hall :green, title: 'Зелёный зал (deluxe)', places: 12

          period '09:00'..'11:00' do
          description 'Утренний сеанс'
          filters genre: 'Comedy', year: 1900..1980
          price 10
          hall :red, :blue
          end

          period '10:00'..'16:00' do
          description 'Спецпоказ'
          title 'The Terminator'
          price 50
          hall :red
          end
        end
      end

      it 'raises RuntimeError' do
        expect{ subject }.to raise_error RuntimeError
      end
    end
  end

  describe '.show' do
    
    context 'when the time is wrong' do
      it 'raise RuntimeError' do
        expect{ theater.show('08:00') }.to raise_error RuntimeError
      end
    end    

    context 'when more then one hall found' do
      subject{ -> {theater.show('11:00')}}
      it { is_expected.to raise_error ArgumentError }
    end	
    
    context 'when we give hall color as argument' do
      subject{ -> {theater.show(:red, '11:00')}}
      it { is_expected.to output(/Now showing:/i).to_stdout }
    end

    # тесты на фильтры: массив и exclude
    context 'when filter is an Array' do
      subject{ -> {theater.show('17:00')}}
      it { is_expected.to output('Now showing: Mad Max: Fury Road 00:00:00 - 02:00:00').to_stdout}
    end

    context 'when filter is exclude_' do
      subject{ -> {theater.show('22:00')}}
      it { is_expected.to output('Now showing: M 00:00:00 - 01:39:00').to_stdout}
    end
  end

  describe '.when?' do
    context 'when name is correct' do
      it 'returns time' do
        expect(theater.when?('M')).to eq("19:00".."22:00")
      end
    end

    context 'when name is incorrect' do
      subject { -> {theater.when?('MMM')}}
      it { is_expected.to raise_error RuntimeError }
    end
  end

  describe '.buy_ticket' do
    context 'when title is correct' do
      subject { -> {theater.buy_ticket('M')}}
      it { is_expected.to output{'Вы купили билет на M'}.to_stdout}
    end

    context 'when title is incorrect' do
      subject { -> {theater.buy_ticket('MMM')}}
      it { is_expected.to raise_error NameError }
    end
  
    context 'when price is 30' do
      before {theater.buy_ticket('M')}
      it 'raises cash' do
        expect(theater.cash.to_i).to equal(30)
      end
    end
  end
end