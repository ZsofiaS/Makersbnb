require 'space'

describe Space do
  let(:moneyInstance) { double() }
  let(:moneyClass) { double(new: moneyInstance) }
  let(:available_from) { double() }
  let(:subject) { described_class.new(moneyClass, 'test space title', 'test description', 1000, available_from) }

  describe '#name' do
    it 'should be a string' do
      expect(subject.name).to be_a_kind_of(String) 
    end

    it 'has a name set when initialized' do
      expect(subject.name).to eq('test space title')
    end
  end

  describe '#description' do
    it 'should be a string' do
      expect(subject.description).to be_a_kind_of(String)
    end
  
    it 'has a description when initialized' do
      expect(subject.description).to eq('test description')
    end
  end

  describe '#price_per_night' do
    it 'should be an instance of Money' do
      expect(subject.price_per_night).to be_a_kind_of(moneyInstance.class)
    end
  end

  describe '#price_per_night_formatted' do
    it 'it calls the format method on price per night' do
      expect(moneyInstance).to receive(:format)
      subject.price_per_night_formatted
    end
  end

  describe '#available_from' do
    it 'should be a date' do
      expect(subject.available_from).to eq(available_from)
    end
  end

  describe '.all' do
    it 'should be an array' do
      expect(described_class.all).to be_a_kind_of(Array)
    end
  end
end