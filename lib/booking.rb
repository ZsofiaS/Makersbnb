class Booking
  attr_reader :space, :date

  def initialize
    @space = nil
    @date = nil
  end

  def submit_request(space, date)
    @space = space
    @date = date
  end
end
