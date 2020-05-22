require 'greeting_generator'

describe GreetingGenerator do
  describe 'Greet' do
    it 'returns a string when greet is called' do
      expect(described_class.greet).to be_a_kind_of(String)
    end

    it 'returns a random greeting "Speak friend and eneter"' do
      srand(200)
      expect(described_class.greet).to eq('Speak friend and enter, ')
    end

    it 'returns a random greeting "Speak friend and eneter"' do
      srand(400)
      expect(described_class.greet).to eq('To infinity and ')
    end
  end
end