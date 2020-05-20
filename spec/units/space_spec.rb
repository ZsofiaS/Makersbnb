require 'space'
require 'pg'

describe Space do
  let(:price_per_night) { double() }
  let(:available_from) { double() }
  let(:available_to) { double() }
  let(:subject) { described_class.new('test space title', 'test description', price_per_night, available_from, available_to) }

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
      expect(subject.price_per_night).to eq(price_per_night)
    end
  end

  describe '#price_per_night_formatted' do
    it 'it calls the format method on price per night' do
      expect(price_per_night).to receive(:format)
      subject.price_per_night_formatted
    end
  end

  describe '#available_from' do
    it 'equals object dependency object passed in on creation' do
      expect(subject.available_from).to eq(available_from)
    end
  end

  describe '#available_to' do
    it 'equals object dependency object passed in on creation' do
      expect(subject.available_to).to eq(available_to)
    end
  end

  describe '.all' do
    it 'should be an array' do
      expect(described_class.all).to be_a_kind_of(Array)
    end
  end

  describe '#save' do
    it 'saves data to the spaces table' do
      expect(subject.save).not_to be_nil
    end
  end

end