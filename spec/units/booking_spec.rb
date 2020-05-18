require 'booking'

describe Booking do
  it "creates booking for space" do
    space = "Mars"
    subject.submit_request(space)
    expect(subject.space).to eq space
  end
end
