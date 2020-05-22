require 'booking'

describe Booking do

  before(:each) do
    @date = Time.new(2021, 05, 12)
    @user = double('User', :id => "1")
    @space = double('Space', :id => "1")
    @subject = Booking.create(space_id: @space.id, user_id: @user.id, date: @date)
    @booking_id = @subject.id
  end

  describe 'Booking attributes' do
    it 'has attributes' do
      expect(@subject.id).to eq @booking_id
      expect(@subject.space_id).to eq @space.id
      expect(@subject.user_id).to eq @user.id
      expect(@subject.status).to eq 'unconfirmed'
    end
  end

  describe '#print_date' do
    it 'prints date' do
      expect(@subject.print_date).to eq '12 - May - 2021'
    end
  end

  describe '.create' do
    it "creates booking for space" do
      expect(@subject).to be_a Booking
    end
  end

  describe '.find' do
    let(:booking) { Booking.find(id: @booking_id) }

    it "finds booking by it'sid" do
      expect(booking.id).to eq @booking_id
    end
  end

  describe '.find_by_space' do
    let(:booking_spaces) { Booking.find_by_space(id: @space.id) }

    it "finds by space id" do
      expect(booking_spaces[0].id).to eq @subject.id
    end
  end

  describe '.find_by_user' do
    let(:booking_spaces) { Booking.find_by_user(id: @user.id) }

    it "finds by space id" do
      expect(booking_spaces[0].user_id).to eq '1'
    end
  end

  describe '#set_status' do
    it 'updates a confirmed status' do
      @subject.set_status('confirmed')
      updated_subject = described_class.find(id: @subject.id)
      expect(updated_subject.status).to eq('confirmed')
    end

    it 'updates a rejected status' do
      @subject.set_status('rejected')
      updated_subject = described_class.find(id: @subject.id)
      expect(updated_subject.status).to eq('rejected')
    end
  end

end
