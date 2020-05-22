require 'space'
require 'pg'

describe Space do
  let(:price_per_night) { double(fractional: 1000) }
  let(:available_from) { double(strftime: '2031-10-10') }
  let(:available_to) { double(strftime: '2044-11-16') }
  let(:subject) { described_class.new(1, 'test space title', 'test description', price_per_night, available_from, available_to, 1) }

  describe '#id' do
    it 'should be a integer' do
      expect(subject.id).to be_a_kind_of(Integer)
    end
  end
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

  describe '#user_id' do
    it 'has a foreign owner id' do
      expect(subject.user_id).to eq(1)
    end
  end

  describe '.all' do
    it 'should be an array' do
      expect(described_class.all).to be_a_kind_of(Array)
    end

    it 'should contain instances of Space' do
      subject.save
      expect(described_class.all.last).to be_a_kind_of(Space)
    end

    it 'should have the correct name from list' do
      new_space = described_class.new(nil, 'new space', 'test description', price_per_night, available_from, available_to, 1).save
      expect(described_class.all.last.name).to eq('new space')
    end
  end

  describe '#.find' do
    it 'finds data from the spaces table' do
      expect(described_class.find(1)).not_to be nil
    end

    it 'should contaion instances of Space'do
      expect(described_class.find(1)).to be_a_kind_of(Space)
    end

    it 'should have a name' do
      expect(described_class.find(1).name).to eq('Mars')
    end

    it 'should have an availability dates' do
      expect(described_class.find(1).available_from).to be_a_kind_of(Date)
      expect(described_class.find(1).available_to).to be_a_kind_of(Date)
      expect(described_class.find(1).available_from.strftime('%Y-%m-%d')).to eq('2020-10-10')
    end

    it 'should have money' do
      expect(described_class.find(1).price_per_night).to be_a_kind_of(Money)
      expect(described_class.find(1).price_per_night.fractional).to eq(1000)
    end
  end

  describe '#save' do
    it 'saves the data with user_id' do
      expect(subject.save).not_to be nil
    end
  end

  describe '#owner_name' do
    it 'should be a string' do
      expect(subject.owner_name).to be_a_kind_of(String)
    end

    it 'should return owner name' do
      expect(subject.owner_name).to eq 'Joe1984'
    end
  end

  describe '.find_by_user' do
    it 'should return a list of spaces that the user owns' do
      DatabaseConnection.query("INSERT INTO spaces (name, description, price, available_from, available_to, user_id) VALUES ('Pluto', 'BEST PLANET TO DIE', '1000', '2020-10-10', '2020-10-12', 1);")
      DatabaseConnection.query("INSERT INTO spaces (name, description, price, available_from, available_to, user_id) VALUES ('Venus', 'BEST PLANET TO DIVING', '1000', '2020-10-10', '2020-10-12', 1);")
      expect(described_class.find_by_user(1).count).to eq(4)
    end
  end

  describe '#correct_date?' do
    it 'returns true if the date is in available range' do
      expect(subject.correct_date?).to eq(true)
    end
  end

  describe '.order_by_desc' do
    it 'sorts desc by price ' do
      expect(described_class.order_by_desc('price')).not_to be nil
    end
  end

  describe '.order_by_asc(value)' do
    it 'sorts asc by price' do
      expect(described_class.order_by_asc('price')).not_to be nil
    end
  end

  describe '.order_by_dates' do
    it 'sorts by spesific dates' do
      expect(described_class.order_by_dates(Date.parse('2031-10-10'), Date.parse('2044-11-16'))).not_to be 'Pluto'
    end
  end 

end
