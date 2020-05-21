require 'booking'

describe Booking do

  shared_context "setup booking" do
    let(:date)        { Time.new(2021, 05, 12) }
    let(:user)        { double('User', :id => "1") }
    let(:space)       { double('Space', :id => "1") }
    let(:subject)     { Booking.create(space_id: space.id, user_id: user.id, date: date) }
    let(:booking_id)  { subject.id }
  end

  describe 'Booking attributes' do
    include_context "setup booking"
    it 'has attributes' do
      expect(subject.id).to eq booking_id
      expect(subject.space_id).to eq space.id
      expect(subject.user_id).to eq user.id
      expect(subject.status).to eq 'unconfirmed'
    end
  end

  describe '#print_date' do
    include_context "setup booking"
    it 'prints date' do
      expect(subject.print_date).to eq '12 - May - 2021'
    end
  end

  describe '.create' do
    include_context "setup booking"
    it "creates booking for space" do
      expect(subject).to be_a Booking
    end
  end

  describe '.find' do
    include_context "setup booking"
    let(:booking) { Booking.find(id: booking_id) }

    it "finds booking by user id" do
      expect(booking.id).to eq booking_id
    end
  end

  describe '.find_by_space' do
    include_context "setup booking"
    let(:booking_space) { Booking.find_by_space(id: space.id) }

    it "finds by space id" do
      expect(booking_space.id).to eq subject.id
    end
  end

  # describe '.find' do
  #   let(:booking) { Booking.find(user_id: user.id) }
  #
  #   it "finds booking by user id" do
  #     expect(subject.id).to eq booking.id
  #   end
  # end
end
