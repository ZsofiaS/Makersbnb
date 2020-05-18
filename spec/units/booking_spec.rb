require 'booking'

describe Booking do

  let(:space) { "Mars" }
  let(:date) { '02-Jun-2020'}
  
  before(:each) do
    subject.submit_request(space, date)
  end
  it "creates booking for space" do
    expect(subject.space).to eq space
  end

  it 'has a date' do
    expect(subject.date).to eq date
  end
end
