require 'booking'

describe Booking do


  let(:subject) { Booking.create(space_id: 1, user_id: 1, date: Time.new)}

  describe '.create' do
    it "creates booking for space" do
      expect(subject).to be_a Booking
      expect(subject.space_id).to eq("1")
      expect(subject.user_id).to eq("1")
    end
  end


  it 'has a date' do
    # expect(subject.date).to eq date
  end

  it 'has an instance' do
    # Booking.create
    # expect(Booking.instance).to be_a Booking
  end
end
