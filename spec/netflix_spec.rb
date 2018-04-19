require './netflix.rb'

describe Netflix do
  
  let(:netflix) { Netflix.new('movies.txt') }  
  let(:big_pay) { netflix.pay(200)}
  describe '.pay' do
    context 'when positive amount' do 
      it 'increases balance' do
        expect{ netflix.pay(5) }.to change{ netflix.balance }.from("$0.00").to("$5.00")
      end
    end
    
    context 'when negative amount' do
      it 'raises RuntimeError' do
        expect{ netflix.pay(-5) }.to raise_error RuntimeError
      end
    end
  end

  describe '.define_filter' do
    before { netflix.pay(300) }

    context 'when only block is given' do
      subject{ -> {netflix.show { |movie| movie.title.include?('Inception') && movie.genre.include?('Action') && movie.year == 2010}}}
      it { is_expected.to output('Now showing: Inception 00:00:00 - 02:28:00').to_stdout }
    end

    context 'when block and argument are given' do
      subject{ -> {netflix.show(title: /the maltese/i) { |movie| !movie.title.include?('Citizen Kane') && !movie.genre.include?('Action') && movie.year > 1935}}}
      it { is_expected.to output('Now showing: The Maltese Falcon 00:00:00 - 01:40:00').to_stdout }
    end

    context 'when only argument is given' do
      subject{ -> {netflix.show(title: /the maltese/i)} }
      it { is_expected.to output('Now showing: The Maltese Falcon 00:00:00 - 01:40:00').to_stdout }
    end

    context 'when filter defined' do
      before { netflix.define_filter(:f1) { |movie| !movie.title.include?('Citizen Kane') && !movie.genre.include?('Action') && movie.year == 1941} }
      subject{ -> {netflix.show(f1: true)} }
      it { is_expected.to output('Now showing: The Maltese Falcon 00:00:00 - 01:40:00').to_stdout }     
    end

    context 'when filter defined' do
      before { netflix.define_filter(:f1) { |movie, year| !movie.title.include?('Citizen Kane') && !movie.genre.include?('Action') && movie.year == year} }
      before { netflix.define_filter(:new_f1, from: :f1, arg: 1941) }
      subject{ -> {netflix.show(new_f1: true, genre: 'Drama')} }
      it { is_expected.to output('Now showing: The Maltese Falcon 00:00:00 - 01:40:00').to_stdout }     
    end    

    context 'when from is incorrect' do
      subject { -> {netflix.define_filter(:new_filter, from: :aaaaaaaaa, arg: 2009)}}
      it { is_expected.to raise_error ArgumentError, 'Такого фильтра не существует' }
    end
  end

  describe '.apply_custom_filters' do
    let(:list) { [0, 1, 2, 3, 4, 5, 6, 7] }
    
    context 'when cusom_filter is empty' do
      it 'changes nothing' do
        expect{ print netflix.apply_custom_filters(list, []).to_s }.to output('[0, 1, 2, 3, 4, 5, 6, 7]').to_stdout
      end
    end
  end

  describe '.show' do
    before { netflix.pay(1) }

    context "when not enough money" do
      it 'raises ArgumentError' do
        expect{ netflix.show(title: /term/i) }.to raise_error ArgumentError, "Need more money"
      end
    end
    
    context "when show a movie" do
      it 'decrease balance' do         
        expect{ netflix.show(title: 'Citizen Kane') }.to change{ netflix.balance }.from("$1.00").to("$0.00")
      end
    end
   
    context "when movie doesn\'t exist" do
      it 'raises ArgumentError' do
        expect{ netflix.show('wadad') }.to raise_error ArgumentError
      end
    end  

    context 'when block is empty' do
      it 'outputs random movie from a list' do
        big_pay
        expect{ netflix.show(title: /the term/i) }.to output{'Now showing: The Terminator 00:00:00 - 01:47:00'}.to_stdout
      end
    end
    
    context 'when block is given' do
      it 'gives the terminator movie' do
        big_pay
        expect{ netflix.show(genre: 'Action') {|movie| movie.title.include?('The Terminator')} }.to output{'Now showing: The Terminator 00:00:00 - 01:47:00'}.to_stdout
      end
    end

    context 'when filters are difined by method define_filter' do
      it 'gives the terminator movie' do 
        big_pay
        netflix.define_filter(:f1) {|movie| movie.title.include?('The Terminator') && movie.genre.include?('Action')}
        expect{ netflix.show(f1: true) }.to output{'Now showing: The Terminator 00:00:00 - 01:47:00'}.to_stdout
      end
    end
  end  

  describe '.how_much?' do
    
    context "when movie costs 3" do
      it 'shows a price' do
        expect(netflix.how_much?("The Terminator").to_i).to match(3)
      end
    end
    
    context "when movie costs 1" do
      it "shows a price" do
        expect(netflix.how_much?("Citizen Kane").to_i).to match(1)
      end
    end  

    context "when movie doesn\'t exist" do 
      it 'should raise ArgumentError' do
        expect{ netflix.how_much?('awdadw') }.to raise_error ArgumentError
      end
    end
  end
end