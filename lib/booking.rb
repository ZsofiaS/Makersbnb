class Booking
  attr_reader :space

  def initialize
    @space = nil
  end

  def submit_request(space)
    @space = space
  end
end
