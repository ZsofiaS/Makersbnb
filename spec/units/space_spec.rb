require_relative '../../space'

describe Space do

  let(:subject) { described_class.new('test space title') }

  describe '#name' do
    it 'should be a string' do
      expect(subject.name).to be_a_kind_of(String) 
    end

    it 'has a name set when initialized' do
      expect(subject.name).to eq('test space title')
    end
  end

  describe '.all' do
    it 'should be an array' do
      expect(described_class.all).to be_a_kind_of(Array)
    end
  end
end