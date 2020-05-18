class Space

  attr_reader :name

  @@spaces = []

  def initialize(name)
    @name = name
  end

  def self.all
    @@spaces
  end

end