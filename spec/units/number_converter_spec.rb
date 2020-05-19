require 'number_converter'

describe NumberConverter do
  describe '.two_decimal_place_float_to_int' do
    it 'converts 10.00 to 1000' do
      expect(described_class.two_decimal_place_float_to_int(10.00)).to eq(1000)
    end
  end
end